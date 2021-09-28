#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label

read -p "Enter First number : " firstnum
read -p "Enter Second number : " secondnum 
read -p "Enter Third number : " thirdnum
sum=$((firstnum + secondnum + thirdnum ))
product =$(( firstnum * secondnum * thirdnum ))
echo "Sum of $firstnum, $secondnum, and $thirdnum is $sum "
echo "Product of $firstnum, $secondnum, and $thirdnum is  $product" 
