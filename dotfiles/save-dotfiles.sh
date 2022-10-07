#!/bin/bash

$msg=$@

run_save(){
  parsed_date=$(date +"%a, %d %B, %y, %H:%m")
  cd ~/coding/self
  git add "./dotfiles"
  git commit -m "dotfiles: $msg -- $parsed_date"
  git push
}

run_save