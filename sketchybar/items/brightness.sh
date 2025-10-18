#!/bin/bash

sketchybar --add item brightness right \
           --set brightness script="$PLUGIN_DIR/brightness.sh" \
           --subscribe brightness brightness_change
