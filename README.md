# Race Condition in Shell Scripting

This repository demonstrates a race condition in shell scripting where two background processes write to files concurrently, leading to unpredictable file content.

## Bug Description
The `bug.sh` script creates two files and runs two background processes. Each process writes to a different file repeatedly. The race condition occurs when both processes attempt to write to their respective files simultaneously. This may result in data corruption and interleaved output from both processes.

## Bug Solution
The `bugSolution.sh` script demonstrates the solution using process synchronization mechanisms.  This is achieved by using locks to ensure only one process writes to the files at a time.