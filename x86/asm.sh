#!/bin/bash
for file in $(find . -name '*.S'); do
    asm -f raw -c i386 -o ${file%.S} < $file
done
