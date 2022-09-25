#!/usr/bin/env bash


flavor=$1


function shared_commands() {
  cd ~/coding/nydogeexchange
}

function run_server(){
  shared_commands
  source venv/nodevenv/bin/activate
  cd server
  npm run dev
}

function run_client(){
  shared_commands
  source venv/nextvenv/bin/activate
  cd client
  npm run dev
} 

function not_found(){
  echo "
    No flavor found!
    Possible flavors are:
    1. srv -> launches nydogeexchange server
    2. client -> launches nydogeexchange client
  "
}

case $flavor in 

  "srv")
  run_server
  ;;

  "client")
  run_client
  ;;

  *)
  not_found
  ;;

esac


