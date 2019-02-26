#!/usr/bin/env bash

for f in ~/.bashrc; do
    echo "Adding local functions to ~/.bashrc"
    sed -i 's|source ~/.firm_extract/functions||' ~/.bashrc
    [ -e "$f" ] && sed -i "1 i\source ~/.firm_extract/functions" ~/.bashrc
    break
done
