#!/bin/bash

COMFORT=${COMFORT:-0.75}
DEFAULT_DPI=96
internal_pattern='^(eDP|LVDS|DSI)'

connected_outputs=$(xrandr --query | grep ' connected' | grep -E '[0-9]+x[0-9]+\+[0-9]+\+[0-9]+')
external_output=$(echo "$connected_outputs" | grep -vE "$internal_pattern" | head -n 1)
internal_output=$(echo "$connected_outputs" | grep -E "$internal_pattern" | head -n 1)
active_output=$( [ -n "$external_output" ] && echo "$external_output" || echo "$internal_output" )
[ -z "$active_output" ] && exit 1

name=$(echo "$active_output" | awk '{print $1}')
resolution=$(echo "$active_output" | grep -Po '\d+x\d+(?=\+\d+\+\d+)' | head -n 1)
width_px=${resolution%x*}
height_px=${resolution#*x}
width_mm=$(echo "$active_output" | grep -Po '\d+(?=mm x)' | head -n 1)
height_mm=$(echo "$active_output" | grep -Po '(?<=mm x )\d+(?=mm)' | head -n 1)
is_internal=$(echo "$name" | grep -qE "$internal_pattern" && echo 0 || echo 1)
size_is_known=$( [ "${width_mm:-0}" -gt 0 ] && [ "${height_mm:-0}" -gt 0 ] && echo 0 || echo 1 )

dpi=$DEFAULT_DPI
if [ "$is_internal" -eq 0 ] && [ "$size_is_known" -eq 0 ]; then
  width_inches=$(awk -v mm="$width_mm" 'BEGIN { print mm / 25.4 }')
  height_inches=$(awk -v mm="$height_mm" 'BEGIN { print mm / 25.4 }')
  horizontal_dpi=$(awk -v px="$width_px" -v inches="$width_inches" 'BEGIN { print px / inches }')
  vertical_dpi=$(awk -v px="$height_px" -v inches="$height_inches" 'BEGIN { print px / inches }')
  physical_dpi=$(awk -v h="$horizontal_dpi" -v v="$vertical_dpi" 'BEGIN { print (h + v) / 2 }')
  dpi=$(awk -v d="$physical_dpi" -v c="$COMFORT" 'BEGIN { printf "%.0f", d * c }')
fi
dpi_out_of_range=$( [ "$dpi" -lt 60 ] || [ "$dpi" -gt 320 ] && echo 0 || echo 1 )
dpi=$( [ "$dpi_out_of_range" -eq 0 ] && echo "$DEFAULT_DPI" || echo "$dpi" )

xrandr --dpi "$dpi"
echo "Xft.dpi: $dpi" | xrdb -merge
command -v notify-send > /dev/null && notify-send -t 2500 "DPI $dpi" "$name  $resolution"
i3-msg restart > /dev/null 2>&1
