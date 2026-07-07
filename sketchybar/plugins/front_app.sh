#!/usr/bin/env bash

# The front_app_switched event sends the name of the newly focused application
# in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  source "$CONFIG_DIR/plugins/icon_map.sh"
  __icon_map "$INFO"
  sketchybar --set "$NAME" icon="$icon_result" label="$INFO"
fi
