#!/bin/bash

echo "Installing atom packages"
apm install `cat atom-packages.list`
