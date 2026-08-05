// Center a window on the screen it currently occupies. Called from
// center-window.sh with (pid, title) of AeroSpace's focused window;
// falls back to the frontmost process when run without args.
// visibleFrame keeps the window clear of the menu bar/notch and Dock.
ObjC.import('Cocoa');

function run(argv) {
  const se = Application('System Events');
  const proc = argv.length >= 1
    ? se.processes.whose({ unixId: Number(argv[0]) })[0]
    : se.processes.whose({ frontmost: true })[0];
  const wins = proc.windows();
  if (wins.length === 0) return;

  // Prefer the title AeroSpace reports: untitled AXUnknown elements can
  // precede the real window in the AX list (e.g. Cisco Secure Client)
  let win = null;
  const wantTitle = argv.length >= 2 ? argv[1] : null;
  if (wantTitle) {
    for (let i = 0; i < wins.length; i++) {
      if (wins[i].name() === wantTitle) { win = wins[i]; break; }
    }
  }
  if (!win) {
    for (let i = 0; i < wins.length; i++) {
      if (wins[i].subrole() === 'AXStandardWindow') { win = wins[i]; break; }
    }
  }
  if (!win) win = wins[0];

  const pos = win.position();
  const size = win.size();

  // AX coordinates are top-left-origin, NSScreen bottom-left-origin;
  // convert using the primary screen's height
  const screens = $.NSScreen.screens;
  const mainH = screens.objectAtIndex(0).frame.size.height;
  const frames = [];
  for (let i = 0; i < screens.count; i++) {
    const f = screens.objectAtIndex(i).visibleFrame;
    frames.push({
      x: f.origin.x,
      y: mainH - (f.origin.y + f.size.height),
      w: f.size.width,
      h: f.size.height,
    });
  }

  const cx = pos[0] + size[0] / 2;
  const cy = pos[1] + size[1] / 2;
  const target =
    frames.find((f) => cx >= f.x && cx < f.x + f.w && cy >= f.y && cy < f.y + f.h) || frames[0];

  win.position = [
    Math.round(target.x + (target.w - size[0]) / 2),
    Math.round(target.y + (target.h - size[1]) / 2),
  ];
}
