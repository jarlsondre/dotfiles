#!/bin/sh

if [ "$SENDER" = "brightness_change" ]; then
  BRIGHTNESS="$INFO"
  case "$BRIGHTNESS" in
    [6-9][0-9]|100) ICON="󰃠"  # High brightness
    ;;
    [3-5][0-9]) ICON="󰃟"      # Medium brightness
    ;;
    [1-9]|[1-2][0-9]) ICON="󰃞"  # Low brightness
    ;;
    *) ICON="󰃚"               # Very low/off
  esac
  sketchybar --set "$NAME" icon="$ICON" label="$BRIGHTNESS%"
fi
