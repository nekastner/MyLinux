#!/bin/bash

git pull --rebase

if [[ -e "$HOME/.zshrc" ]];
then
	source "$HOME/.zshrc"
fi
