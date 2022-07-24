#!/bin/bash

echo "Enter your name:"
read name

echo "Enter your age:"
read age

echo "Hello $name, you are $age old."
sleep 2

echo "Calculating"
sleep 1
echo "..........."
sleep 1
echo "****......."
sleep 1
echo "********..."
sleep 1
echo "***********"


getrich=$((( $RANDOM % 15 ) + $age ))

echo "$name, you will become millionaire when you are $getrich years old with some hard work and luck!! "

