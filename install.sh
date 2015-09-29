#!/bin/bash

echo "Creating temporary dir.."
mkdir ./tmp
cd ./tmp
echo "Downloading fonts.."
wget "https://github.com/chrissimpkins/Hack/tree/master/build/ttf/Hack-Bold.ttf" -q
wget "https://github.com/chrissimpkins/Hack/tree/master/build/ttf/Hack-BoldItalic.ttf" -q
wget "https://github.com/chrissimpkins/Hack/tree/master/build/ttf/Hack-Italic.ttf" -q
wget "https://github.com/chrissimpkins/Hack/tree/master/build/ttf/Hack-Regular.ttf" -q
cd ..
echo "Installing fonts.."
sudo mv ./tmp/*.ttf /Library/Fonts/
rm -rf ./tmp
echo "Setting font permissions.."
sudo chown root:wheel /Library/Fonts/Hack-Bold.ttf
sudo chown root:wheel /Library/Fonts/Hack-BoldItalic.ttf
sudo chown root:wheel /Library/Fonts/Hack-Italic.ttf
sudo chown root:wheel /Library/Fonts/Hack-Regular.ttf

echo "Checking if Atom installed.."
if !type "apmm" >/dev/null 2>/dev/null; then
	echo "Please install Atom first!"
	open "https://atom.io/"
	exit 0
fi
echo "OK"

echo "Installing Atom packages"
apm install `cat atom-packages.list`
