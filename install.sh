#!/bin/bash

echo "Checking if Atom installed.."
if !type "apmm" >/dev/null 2>/dev/null; then
	echo "Please install Atom first!"
	open "https://atom.io/"
	exit 0
fi
echo "OK"

echo "Installing Atom packages"
apm install `cat atom-packages.list`
