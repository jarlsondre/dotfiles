#!/usr/bin/env bash

# Bulk updater for the workspace pills: highlights the focused workspace and
# fills each pill with the icons of the apps running in it. Empty, unfocused
# workspaces are hidden to keep the bar clean.
# (No associative arrays: macOS ships bash 3.2, so we use apps_<ws> variables.)

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/icon_map.sh"

focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

while IFS='|' read -r ws app; do
  [ -z "$ws" ] && continue
  case "$ws" in *[!A-Za-z0-9_]*) continue ;; esac
  __icon_map "$app"
  eval "apps_$ws=\"\${apps_$ws}\$icon_result\""
done < <(aerospace list-windows --all --format '%{workspace}|%{app-name}')

args=()
for sid in $(aerospace list-workspaces --all); do
  case "$sid" in *[!A-Za-z0-9_]*) continue ;; esac
  eval "icons=\"\${apps_$sid}\""

  if [ "$sid" = "$focused" ]; then
    args+=(--set "space.$sid" drawing=on background.drawing=on \
      background.color="$ACCENT_COLOR" icon.color="$BAR_COLOR" label.color="$BAR_COLOR")
  elif [ -n "$icons" ]; then
    args+=(--set "space.$sid" drawing=on background.drawing=off \
      icon.color="$TEXT_COLOR" label.color="$TEXT_COLOR")
  else
    args+=(--set "space.$sid" drawing=off)
    continue
  fi

  if [ -n "$icons" ]; then
    args+=(--set "space.$sid" label="$icons" label.drawing=on)
  else
    args+=(--set "space.$sid" label.drawing=off)
  fi
done

sketchybar "${args[@]}"
