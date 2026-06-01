#!/bin/bash
echo "all variables passed to script: $@"
echo "number of variables passed: $#"
echo "first variable: $1"
echo "if we use inside script we will get script name: $0"
echo "who is running this: $USER"
echo "which directory: $PWD"
echo "home dir: $HOME"
echo "pid of the current script: $$"
sleep 5 &
echo "PID of the background command running just now: $!"
wait $!
echo "Line number: $LINENO"
echo "Script executed in $SECONDS seconds"
echo "Random number: $RANDOM"
echo "Exit code of previous command: $?"
