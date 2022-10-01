#!/bin/bash

run_save(){
  parsed_date=date +"%d %B, %y, %H:%m"
  echo parsed_date
  cd ~/coding/self
  git add "./dotfiles"
  git commit -m "dotfiles: $parsed_date"
  git push
}

run_save