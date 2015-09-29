#!/bin/bash

echo "Creating temporary dir.."
mkdir ./tmp

echo "Downloading fonts.."
cd ./tmp
wget "https://github.com/chrissimpkins/Hack/tree/master/build/ttf/Hack-Bold.ttf" -q
echo "Downloaded Hack-Bold.ttf ✓"
wget "https://github.com/chrissimpkins/Hack/tree/master/build/ttf/Hack-BoldItalic.ttf" -q
echo "Downloaded Hack-BoldItalic.ttf ✓"
wget "https://github.com/chrissimpkins/Hack/tree/master/build/ttf/Hack-Italic.ttf" -q
echo "Downloaded Hack-Italic.ttf ✓"
wget "https://github.com/chrissimpkins/Hack/tree/master/build/ttf/Hack-Regular.ttf" -q
echo "Downloaded Hack-Regular.ttf ✓"
cd ..

echo "Installing fonts.."
sudo mv ./tmp/*.ttf /Library/Fonts/

echo "Deleting temporary dir.."
rm -rf ./tmp

echo "Setting font permissions.."
sudo chown root:wheel /Library/Fonts/Hack-Bold.ttf
sudo chown root:wheel /Library/Fonts/Hack-BoldItalic.ttf
sudo chown root:wheel /Library/Fonts/Hack-Italic.ttf
sudo chown root:wheel /Library/Fonts/Hack-Regular.ttf

echo "Checking if phpmd is installed.."
if !type "phpmd" >/dev/null 2>/dev/null; then
	echo "Not installed.. Checking if homebrew is installed.."

	if !type "brew" >/dev/null 2>/dev/null; then
		echo "Homebrew is not installed, installing"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		brew doctor
	fi

	echo "Installing phpmd.."
	brew install phpmd
fi
echo "OK ✓"

echo "Checking if Atom installed.."
if !type "apm" >/dev/null 2>/dev/null; then
	echo "Please install Atom first!"
	open "https://atom.io/"
	exit 0
fi
echo "OK ✓"

echo "Installing Atom packages.."
apm install `cat atom-packages.list`

echo "Configuring Atom.."
HOME_DIR=$HOME/.atom
mkdir $HOME_DIR
mv ./atom-config-files/* $HOME_DIR
echo "    rulesets: $HOME_DIR/phpmd-rules.xml" >> $HOME_DIR/config.cson
