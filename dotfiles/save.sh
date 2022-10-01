
run_save(){
  parsed_date = $date+"%d, %B, %y, %HH:mm"
  cd ~/coding/self
  git add "./dotfiles"
  git commit -m "dotfiles:"
  git push
}

run_save