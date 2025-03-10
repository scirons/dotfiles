#!/bin/bash

sketchybar --add item brew right \
  --add event brew_update="$(brew update)" \
  --set brew icon=$COUNT \
  --set brew script=$PLUGIN_DIR/brew.sh \
  --subscribe brew brew_update
