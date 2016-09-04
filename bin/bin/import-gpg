#!/bin/bash

# modded from https://gist.github.com/joostrijneveld/59ab61faa21910c8434c

for f in keyfrag-*.png; do zbarimg --raw $f | head -c -1 > $f.out ; done
cat *.out | base64 -d | paperkey --pubring ~/.gnupg/pubring.gpg | gpg --import
