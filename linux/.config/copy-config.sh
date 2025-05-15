#!/bin/bash

repo=$HOME/coding/self/linux

declare -A pairs=(
  ["$HOME/.zshrc"]="$repo/.zshrc"
  ["$HOME/.profile"]="$repo/.profile"
  ["$HOME/.config/i3/config"]="$repo/.config/i3/config"
  ["$HOME/.config/picom/picom.conf"]="$repo/.config/picom/picom.conf"
  ["$HOME/.config/alacritty/alacritty.toml"]="$repo/.config/alacritty/alacritty.toml"
  ["$HOME/.config/Code/User/settings.json"]="$repo/.config/Code/settings.json"
  ["$HOME/.config/Code/User/keybindings.json"]="$repo/.config/Code/keybindings.json"
  ["$HOME/.config/i3status-rust/config.toml"]="$repo/.config/i3status-rust/config.toml"
)

for src in "${!pairs[@]}"; do
  dst=${pairs[$src]}
  cp -- "$src" "$dst"
done
