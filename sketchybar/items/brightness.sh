#!/bin/bash

# Hidden until the first brightness_change event: macOS only reports
# brightness for the built-in display, so this stays hidden when docked.
sketchybar --add item brightness right \
           --set brightness drawing=off \
           script="$PLUGIN_DIR/brightness.sh" \
           --subscribe brightness brightness_change
