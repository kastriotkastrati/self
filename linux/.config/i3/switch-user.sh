#!/bin/sh

user="$1"
session=$(loginctl list-sessions --no-legend \
    | awk -v u="$user" '$3 == u && $4 == "seat0" && $6 == "user" { print $1; exit }')

if [ -n "$session" ]; then
    loginctl activate "$session"
else
    dm-tool switch-to-greeter
fi
