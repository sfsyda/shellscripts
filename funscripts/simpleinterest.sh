#!/bin/bash


echo "Enter principal amount:"
read principal

echo "Enter interest rate:"
read irate

echo "Enter time period:"
read period

interst=$(echo $irate*$period | bc -l)
total=$(echo $interst+$principal | bc -l)

echo "Total interest = $interst"
echo "Total amount = $total"



