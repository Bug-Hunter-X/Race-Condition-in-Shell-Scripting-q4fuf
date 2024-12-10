#!/bin/bash

# This script demonstrates a race condition in shell scripting.

# Create two files
touch file1.txt
touch file2.txt

# Start two background processes simultaneously
(while true; do echo "Process 1 writing to file1.txt"; echo "Process 1" >> file1.txt; sleep 1; done) &
(while true; do echo "Process 2 writing to file2.txt"; echo "Process 2" >> file2.txt; sleep 1; done) &

# Wait for some time to see the race condition
sleep 5

# Stop both background processes
kill $!
kill $!

# The race condition causes unpredictable content in the files
cat file1.txt
cat file2.txt