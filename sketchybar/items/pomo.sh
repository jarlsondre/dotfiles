#!/bin/bash

# Pomodoro countdown (see plugins/pomo.sh); hidden when no session runs.
sketchybar --add item pomo right \
  --set pomo drawing=off \
  update_freq=1 \
  script="$PLUGIN_DIR/pomo.sh"
