#!/bin/sh

# Only visible while music is actually playing.

source "$CONFIG_DIR/colors.sh"

if ! pgrep -xq Spotify; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

STATE="$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)"

if [ "$STATE" = "playing" ]; then
  TRACK="$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null)"
  ARTIST="$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null)"
  sketchybar --set "$NAME" drawing=on icon.color="$GREEN" \
    label="$TRACK — $ARTIST" label.color="$TEXT_COLOR"
else
  sketchybar --set "$NAME" drawing=off
fi
