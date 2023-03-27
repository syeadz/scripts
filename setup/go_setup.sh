#!/bin/bash

EXPORT="Now you need to add export PATH=%\$PATH:/usr/local/go/bin to .bashrc (if you havent)"

NAME="go1.20.2.linux-amd64.tar.gz"

delete_go () {
  rm -rf /usr/local/go
}

install_go () {
  wget -O /tmp/$NAME https://go.dev/dl/$NAME
  tar -C /usr/local -xzf /tmp/$NAME
  rm /tmp/$NAME
  echo "GO installed successfully"
  echo $EXPORT
}

check_root() {
  if [ "$EUID" -ne 0 ]; then 
    echo "error: not root (use sudo)" >&2 ; exit
    exit
  fi
}

check_root

read -p "Do you already have GO installed? ~WILL DELETE CURRENT INSTALL~ (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  delete_go
  install_go
elif [[ $REPLY =~ ^[Nn]$ ]]
then
  install_go
else
  exit
fi

