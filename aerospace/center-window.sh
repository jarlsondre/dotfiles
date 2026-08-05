#!/bin/bash
# Center the focused window. The focused window is resolved through
# AeroSpace because System Events' "frontmost" misses accessory apps
# (e.g. Cisco Secure Client, which never registers as frontmost).
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
IFS='|' read -r pid title < <(aerospace list-windows --focused --format '%{app-pid}|%{window-title}')
[ -n "$pid" ] || exit 0
exec osascript -l JavaScript "$(dirname "$0")/center-window.js" "$pid" "$title"
