
run_save(){
  parsed_date=$date+"%d, %B, %y, %HH:mm"
  cd ~/coding/self
  git add "./dotfiles"
  git commit -m "dotfiles: $parsed_date"
  git push
}

run_save