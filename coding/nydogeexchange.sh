#!/usr/bin/env bash


flavor=$1


function shared_start_commands() {
  cd ~/coding/nydogeexchange
}


function run_server(){
  shared_start_commands
  source venv/nodevenv/bin/activate
  cd server
  code .
  npm run dev
}

function run_client(){
  shared_start_commands
  source venv/nextvenv/bin/activate
  cd client
  code .
  npm run dev
} 

function run_flask() {
  shared_start_commands
  source venv/pyvenv/bin/activate
  cd processing
  code .
  flask run
}

function not_found(){
  echo "
    No flavor found!
    Possible flavors are:
    1. srv -> launches nydogeexchange server
    2. client -> launches nydogeexchange client
    3. flask -> launches flask processor
  "
}

case $flavor in 

  "srv")
  run_server
  ;;

  "client")
  run_client
  ;;

  "flask")
  run_flask
  ;;

  *)
  not_found
  ;;

esac



