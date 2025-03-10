#!/bin/sh

sketchybar --add item apple.logo left \
  --set apple.logo background.image="/Users/scirons/scirons.png" background.image.scale="0.048" \
  background.color="$BAR_COLOR" \
  icon.font="Frelser-F2:Regular:16.0" \
  click_script="osascript -e 'tell application \"System Events\" to click menu bar item \"Apple\" of menu bar 1 of application process \"Finder\"'"
