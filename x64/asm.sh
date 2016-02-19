#!/bin/bash
for file in $(find . -name '*.S'); do
    # install pwntools
    asm -f raw -c amd64 -o ${file%.S} < $file
done
