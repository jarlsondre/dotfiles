#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set "$NAME" \
      background.drawing=on \
      background.color="$ACCENT_COLOR" \
      label.color="$BAR_COLOR"
else
    sketchybar --set "$NAME" \
      background.drawing=off \
      background.color=0x00000000 \
      label.color="$ACCENT_COLOR"
fi
