// Hit-tests the mouse against sketchybar's popup windows. Prints:
//   "inside"  – cursor is over a popup (or the pill strip right above it)
//   "outside" – a popup is open but the cursor is elsewhere
//   "none"    – no popup window found
// Popups are the sketchybar windows on a positive window layer (101); the bar
// and its per-item windows sit on layer -20.
// Used by plugins/space_popup_watch.sh. Compiled on demand by sketchybarrc.
import CoreGraphics
import Foundation

let cursor = CGEvent(source: nil)!.location

guard let list = CGWindowListCopyWindowInfo([.optionOnScreenOnly], kCGNullWindowID)
  as? [[String: Any]]
else {
  print("none")
  exit(0)
}

var found = false
var inside = false

for w in list {
  guard let owner = w[kCGWindowOwnerName as String] as? String, owner == "sketchybar",
    let layer = w[kCGWindowLayer as String] as? Int, layer > 0,
    let b = w[kCGWindowBounds as String] as? [String: CGFloat]
  else { continue }

  let r = CGRect(x: b["X"]!, y: b["Y"]!, width: b["Width"]!, height: b["Height"]!)
  if r.minX < -9000 || r.minY < -9000 { continue }  // hidden popups are parked off-screen
  found = true
  // Pad the popup rect: 50pt up to cover the pill + gap above it, a little slack around
  let region = CGRect(x: r.minX - 15, y: r.minY - 50, width: r.width + 30, height: r.height + 60)
  if region.contains(cursor) { inside = true }
}

print(found ? (inside ? "inside" : "outside") : "none")
