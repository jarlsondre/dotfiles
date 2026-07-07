#!/bin/sh

# Connectivity indicator: wifi/wired icon, purple + label when a VPN is up,
# muted + label when offline. (No SSID: macOS redacts it these days.)

source "$CONFIG_DIR/colors.sh"

# VPN detection, from most to least specific:
# 1. Cisco Secure Client CLI (split tunnel, so the route check misses it)
# 2. macOS-native VPN profiles (IKEv2 etc.)
# 3. default route through a tunnel interface — catches WireGuard-based apps
#    like Mullvad and Proton (idle system utuns never own the default route)
VPN=""
if [ -x /opt/cisco/secureclient/bin/vpn ] &&
  /opt/cisco/secureclient/bin/vpn state 2>/dev/null | grep -q "state: Connected"; then
  VPN="on"
elif scutil --nc list 2>/dev/null | grep -q Connected; then
  VPN="on"
else
  case "$(route -n get default 2>/dev/null | awk '/interface:/ {print $2}')" in
    utun*) VPN="on" ;;
  esac
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
