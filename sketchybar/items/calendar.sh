#!/bin/bash

sketchybar --add item calendar right \
  --set calendar icon="$(date '+%a %d %b')" \
  update_freq=30 \
  script="$PLUGIN_DIR/calendar.sh"
