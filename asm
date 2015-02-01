#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 .S"
fi

nasm -f bin -o ${1%.S} ${1%.S}.S
