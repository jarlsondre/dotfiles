#!/bin/bash

# Spotify posts a distributed notification on every playback change; sketchybar
# turns it into the custom spotify_change event. Click to play/pause.
sketchybar --add event spotify_change "com.spotify.client.PlaybackStateChanged" \
           --add item spotify right \
           --set spotify drawing=off \
           icon="" \
           icon.color=$GREEN \
           label.max_chars=35 \
           scroll_texts=on \
           script="$PLUGIN_DIR/spotify.sh" \
           click_script="osascript -e 'tell application \"Spotify\" to playpause'" \
           --subscribe spotify spotify_change system_woke
