#!/bin/bash

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

echo "Will create new SSH key for Github"
read -p "Do you want to proceed? (yes/no) " yn

case $yn in 
	yes ) echo proceeding...;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac

read -p "Name: " NAME
read -p "Email: " EMAIL

git config --global user.name "${NAME}"
git config --global user.email "${EMAIL}"

echo "Git config set..."
echo "Generating SSH..."

ssh-keygen -t ed25519 -C $EMAIL
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "SSH KEY:"
cat ~/.ssh/id_ed25519.pub
echo "Git configs:"
git config --list | grep user.name | cat
git config --list | grep user.email | cat
