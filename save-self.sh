#!/bin/bash


run_save() {
  cd ~/coding/self
  parsed_date=$(date +"%a, %d %B, %y, %H:%m")
  git add .
  git commit -m "save: $@ -- $parsed_date"
  git push
}

run_save