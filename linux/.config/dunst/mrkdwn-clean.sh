#!/bin/sh
summary="$2"
body="$3"
clean=$(printf '%s' "$body" | /usr/bin/sed -E '
s/<([^|>]*)\|([^>]*)>/<a href="\1">\2<\/a>/g
s/<(https?:\/\/[^>"]*)>/<a href="\1">\1<\/a>/g
s/<!([^>|]*)>/@\1/g
')
/usr/bin/dunstify -a Slack-clean "$summary" "$clean"
