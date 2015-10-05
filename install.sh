#!/bin/bash

echo "Checking if Atom is installed.."
if !type "apm" >/dev/null 2>/dev/null; then
	echo "Please install Atom first!"
	open "https://atom.io/"
	exit 0
fi
echo "OK"

echo "Checking if phpmd is installed.."
if !type "phpmd" >/dev/null 2>/dev/null; then
	echo "Not installed.. Checking if homebrew is installed.."

	if !type "brew" >/dev/null 2>/dev/null; then
		echo "Homebrew is not installed, installing"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		brew doctor
		brew tap homebrew/dupes
		brew tap homebrew/versions
		brew tap homebrew/homebrew-php
		brew update
		brew upgrade
	fi

	echo "Installing phpmd.."
	brew install phpmd
fi
echo "OK"

echo "Checking if scss-lint is installed.."
if !type "scss-lint" >/dev/null 2>/dev/null; then
	sudo gem install scss-lint
fi
echo "OK"

echo "Installing Atom packages.."
apm install `cat atom-packages.list`

echo "Configuring Atom.."
HOME_DIR=$HOME/.atom-script
mkdir $HOME_DIR
cp ./atom-config-files/* $HOME_DIR
echo "    rulesets: \"$HOME_DIR/phpmd-rules.xml\"" >> $HOME_DIR/config.cson
