#!/bin/sh

# Closes the workspace popup as soon as the mouse leaves the pill + popup
# area, so it never needs a second click to dismiss.

if [ "$SENDER" = "mouse.exited.global" ]; then
  sketchybar --set "$NAME" popup.drawing=off
fi
