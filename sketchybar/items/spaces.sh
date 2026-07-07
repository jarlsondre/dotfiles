#!/bin/bash

sketchybar --add event aerospace_workspace_change

# One item per workspace: icon = workspace name, label = icons of the apps in
# it (sketchybar-app-font renders ":appname:" ligatures as icons). Left click
# switches workspace, right click opens a popup listing the open windows.
for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item space.$sid left \
    --set space.$sid \
    icon="$sid" \
    icon.padding_left=8 \
    icon.padding_right=2 \
    icon.color=$TEXT_COLOR \
    icon.font="SN Pro:Bold:13.0" \
    label.font="sketchybar-app-font:Regular:14.0" \
    label.padding_left=2 \
    label.padding_right=8 \
    label.y_offset=-1 \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.height=22 \
    background.drawing=off \
    click_script="$PLUGIN_DIR/space_click.sh"
done

# A single hidden item keeps all workspace pills up to date (highlight + app
# icons) with one aerospace query per event instead of one per workspace.
sketchybar --add item spaces_updater left \
  --set spaces_updater drawing=off \
  script="$PLUGIN_DIR/aerospace.sh" \
  --subscribe spaces_updater aerospace_workspace_change front_app_switched system_woke
