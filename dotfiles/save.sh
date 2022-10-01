
run_save(){
  cd ~/coding/self
  git add "./dotfiles"
  git commit -m "dotfiles: $date"
  git push
}

run_save