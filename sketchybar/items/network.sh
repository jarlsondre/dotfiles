#!/bin/bash

sketchybar --add item network right \
           --set network update_freq=20 \
           script="$PLUGIN_DIR/network.sh" \
           --subscribe network wifi_change system_woke
