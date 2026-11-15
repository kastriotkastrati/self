#!/bin/sh

user=$(sed -n "${1}p" "$HOME/.config/i3/switch-user.local" 2>/dev/null)
session=$(loginctl list-sessions --no-legend \
    | awk -v u="$user" '$3 == u && $4 == "seat0" && $6 == "user" { print $1; exit }')

if [ -n "$session" ]; then
    loginctl activate "$session"
else
    dm-tool switch-to-greeter
fi
