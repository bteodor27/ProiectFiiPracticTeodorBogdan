#!/bin/bash
if [ -d received_files ]; then
        rm -d received_files
fi
mkdir received_files
nc -l 400 > "received_files/ceva"

