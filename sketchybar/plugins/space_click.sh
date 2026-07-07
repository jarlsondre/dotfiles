#!/usr/bin/env bash

# Left click: switch to the workspace.
# Right click: toggle a popup listing the windows in it (click one to focus it).

sid="${NAME#space.}"

if [ "$BUTTON" != "right" ]; then
  aerospace workspace "$sid"
  exit 0
fi

sketchybar --remove "/space\.$sid\.win\..*/" 2>/dev/null

i=0
while IFS='|' read -r wid app title; do
  [ -z "$wid" ] && continue
  label="$app"
  [ -n "$title" ] && [ "$title" != "$app" ] && label="$app — ${title:0:40}"
  sketchybar --add item "space.$sid.win.$i" "popup.space.$sid" \
    --set "space.$sid.win.$i" \
    label="$label" \
    icon.drawing=off \
    background.drawing=off \
    click_script="aerospace focus --window-id $wid; sketchybar --set space.$sid popup.drawing=off"
  i=$((i + 1))
done < <(aerospace list-windows --workspace "$sid" --format '%{window-id}|%{app-name}|%{window-title}')

if [ $i -eq 0 ]; then
  sketchybar --add item "space.$sid.win.0" "popup.space.$sid" \
    --set "space.$sid.win.0" label="(empty)" icon.drawing=off background.drawing=off
fi

sketchybar --set "space.$sid" popup.drawing=toggle
