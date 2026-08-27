#!/bin/sh

# Live pomodoro countdown, fed by one `pomo api json` call (exit 1 / empty
# output = no session). Single call keeps the fields mutually consistent
# and the per-tick cost to a minimum. Colors mirror the pomo TUI.

source "$CONFIG_DIR/colors.sh"

# sketchybar's plugin environment has a minimal PATH: cargo bin for pomo,
# homebrew bin for jq.
PATH="$HOME/.cargo/bin:/opt/homebrew/bin:$PATH"

JSON="$(pomo api json 2>/dev/null)"
if [ -z "$JSON" ]; then
  # Idle backoff: no session, so poll lazily (item may appear up to 5s
  # after a session starts; the countdown itself is always 1s-fresh).
  sketchybar --set "$NAME" drawing=off update_freq=5
  exit 0
fi

IFS="$(printf '\t')" read -r PHASE PAUSED REMAINING PROJECT <<EOF
$(printf '%s' "$JSON" | jq -r '[.phase, (.paused|tostring), (.remaining_secs|tostring), .project] | @tsv')
EOF

CLOCK="$(printf '%02d:%02d' $((REMAINING / 60)) $((REMAINING % 60)))"

if [ "$PAUSED" = "true" ]; then
  ICON="󰏤" COLOR="$YELLOW"
elif [ "$PHASE" = "work" ]; then
  ICON="󰔛" COLOR="$GREEN"
elif [ "$PHASE" = "long-break" ]; then
  ICON="󰒲" COLOR="$ACCENT_COLOR"
else
  ICON="󰅶" COLOR="$CYAN"
fi

sketchybar --set "$NAME" drawing=on update_freq=1 icon="$ICON" \
  icon.color="$COLOR" label="$PROJECT $CLOCK" label.color="$TEXT_COLOR"
