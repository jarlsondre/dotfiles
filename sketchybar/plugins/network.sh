#!/bin/sh

# Connectivity indicator: wifi/wired icon, purple + label when the Cisco VPN
# is up, muted + label when offline. (No SSID: macOS redacts it these days.)

source "$CONFIG_DIR/colors.sh"

VPN=""
if [ -x /opt/cisco/secureclient/bin/vpn ]; then
  /opt/cisco/secureclient/bin/vpn state 2>/dev/null | grep -q "state: Connected" && VPN="on"
elif scutil --nc list 2>/dev/null | grep -q Connected; then
  VPN="on"
fi

if ipconfig getsummary en0 2>/dev/null | grep -q "SSID : "; then
  ICON="󰖩" # wifi
elif route -n get default >/dev/null 2>&1; then
  ICON="󰈀" # wired
else
  sketchybar --set "$NAME" icon="󰖪" icon.color="$MUTED_COLOR" \
    label="offline" label.drawing=on label.color="$MUTED_COLOR"
  exit 0
fi

if [ -n "$VPN" ]; then
  sketchybar --set "$NAME" icon="$ICON" icon.color="$ACCENT_ALT" \
    label="VPN" label.drawing=on label.color="$ACCENT_ALT"
else
  sketchybar --set "$NAME" icon="$ICON" icon.color="$TEXT_COLOR" label.drawing=off
fi
