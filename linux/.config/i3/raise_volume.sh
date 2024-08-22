#!/bin/bash

MAX_VOLUME=150
current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
potential_new_volume=$((current_volume + 5))
potential_new_volume_exceeds_max=$( [ "$potential_new_volume" -gt "$MAX_VOLUME" ] && echo 0 || echo 1 )
new_volume=$( [ "$potential_new_volume_exceeds_max" -eq 0 ] && echo "$MAX_VOLUME" || echo "$potential_new_volume" )

pactl set-sink-volume @DEFAULT_SINK@ "$new_volume"%
