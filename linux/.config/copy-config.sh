#!/bin/bash

repo=$HOME/coding/self/linux

declare -A pairs=(
  ["$HOME/.zshrc"]="$repo/.zshrc"
  ["$HOME/.profile"]="$repo/.profile"
  ["$HOME/.config/i3/config"]="$repo/.config/i3/config"
  ["$HOME/.config/i3/switch-user.sh"]="$repo/.config/i3/switch-user.sh"
  ["$HOME/.config/picom/picom.conf"]="$repo/.config/picom/picom.conf"
  ["$HOME/.config/alacritty/alacritty.toml"]="$repo/.config/alacritty/alacritty.toml"
  ["$HOME/.config/Code/User/settings.json"]="$repo/.config/Code/settings.json"
  ["$HOME/.config/Code/User/keybindings.json"]="$repo/.config/Code/keybindings.json"
  ["$HOME/.config/i3status-rust/config.toml"]="$repo/.config/i3status-rust/config.toml"
  ["$HOME/.config/dunst/dunstrc"]="$repo/.config/dunst/dunstrc"
  ["$HOME/.config/dunst/mrkdwn-clean.sh"]="$repo/.config/dunst/mrkdwn-clean.sh"
  ["$HOME/.config/dunst/notification-center.py"]="$repo/.config/dunst/notification-center.py"
  ["$HOME/.config/rofi/themes/spotlight-dark.rasi"]="$repo/.config/rofi/themes/spotlight-dark.rasi"
)

for src in "${!pairs[@]}"; do
  dst=${pairs[$src]}
  mkdir -p "$(dirname "$dst")"
  cp -- "$src" "$dst"
done
