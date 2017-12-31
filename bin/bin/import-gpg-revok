#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input.png output.txt"
    exit 1
fi

zbarimg --raw $1 > $2
