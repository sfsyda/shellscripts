#!/bin/bash

echo "Enter principal amount:"
read p

echo "Enter interest rate:"
read irate

echo "Enter number of years:"
read t

echo "Enter compound frequency:"
echo "1 - monthly"
echo "2 - querterly"
echo "3 - semi-anually"
echo "4 - anually"
read freq

case $freq in
    1) echo "Frequency is monthly"; n=12  ;;
    2) echo "Frequency is querterly"; n=4 ;;
    3) echo "Frequency is semi-anually"; n=2;;
    4) echo "Frequency is anually"; n=1 ;;
    *) echo "Invalid frequency $freq"; exit 1;;
esac

r=$(echo "$irate/100" | bc -l)
formula="((1+($r/$n)) ^ ($n*$t))*$p"

echo "Interst formula: $formula" 

amount=$(echo "$formula" | bc -l)
interest=$(echo "$amount-$p" | bc -l)

irounded=$(printf '%.2f' $interest)
arounded=$(printf '%.2f' $amount)

echo "Total interest earned in years $years = $irounded"
echo "Total amount after $years years is $arounded"


