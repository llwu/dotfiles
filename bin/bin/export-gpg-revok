#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 gpg_id output.png"
    exit 1
fi

gpg --armor --gen-revoke $1 | qrencode -o $2
