#!/bin/bash

# This script demonstrates a solution to the race condition using locks.

# Create two files
touch file1.txt
touch file2.txt

# Function to write to a file safely
write_to_file() {
  local file=$1
  local message=$2
  flock -n 200  # acquire a lock for the file descriptor 200 (file)
  if [ $? -eq 0 ]; then
    echo "$message" >> "$file"
  else
    echo "Error: Could not acquire lock for $file"
    exit 1
  fi
  flock -u 200 # unlock the file
}

# Start two processes
(while true; do write_to_file file1.txt "Process 1 writing to file1.txt"; write_to_file file1.txt "Process 1"; sleep 1; done) &
(while true; do write_to_file file2.txt "Process 2 writing to file2.txt"; write_to_file file2.txt "Process 2"; sleep 1; done) &

# Wait for some time to see the corrected behaviour
sleep 5

# Stop both background processes
kill $!
kill $!

# The content should now be predictable
cat file1.txt
cat file2.txt