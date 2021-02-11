#!/bin/bash

filename=$1 #assigned the text file to a command line argument
echo "This is the filename: $filename"
women=$( grep "F" $1 |  egrep -o '[0-9]+') # filters the lines in the text file having F and returns only the integers
men=$( grep "M" $1 | egrep -o '[0-9]+') #filters the lines in the text file having M and retrns only the integers

echo $women
echo $men


echo "The average of the women's age is `echo $women | awk -v RS=' ' '{sum+=$women; count++} END{print sum/count}'` years old"
echo "The average of the men's age is `echo $men | awk -v RS=' ' '{sum+=$men; count++} END{print sum/count}'` years old"


