#!/bin/sh

# Watches an open workspace popup and closes it as soon as the cursor is no
# longer over the popup window (or the pill right above it). Started by
# space_click.sh; the helper hit-tests against the popup's real window rect,
# so this works on any display and closes on sideways movement too.
# Without the helper it degrades to a plain timeout.

ITEM="$1"
GUARD="$CONFIG_DIR/helpers/popup_guard"

i=0
while [ $i -lt 120 ]; do # ~30s cap
  sleep 0.25
  i=$((i + 1))

  case "$(sketchybar --query "$ITEM" | awk '/"popup"/ {f=1} f && /"drawing"/ {gsub(/[",]/, ""); print $2; exit}')" in
    off) exit 0 ;; # already closed (entry clicked, toggled, or mouse event fired)
  esac

  if [ -x "$GUARD" ] && [ "$("$GUARD")" = "outside" ]; then
    break
  fi
done

sketchybar --set "$ITEM" popup.drawing=off
