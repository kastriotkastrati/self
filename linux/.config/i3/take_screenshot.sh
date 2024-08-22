#!/bin/bash

NOW=$(date +%d-%b-%Y_%H-%M-%S)
FORMAT="png"
PATH="$HOME/data/screenshots/screenshot_$NOW.$FORMAT"
$HOME/.nix-profile/bin/maim > $PATH
