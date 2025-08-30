#!/bin/bash

if ! output=$(netstat -r);then
echo "Error: failed to execute netstat command"
exit 1

echo $output
exit 0
