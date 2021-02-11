#!/bin/bash

filename=$1 #assigned the text file to a command line argument


echo "This is the filename: $filename"
women=$( grep "F" $1 |  grep -o -E '[0-9]+') # filters the lines in the text file having F which indicates femail
men=$( grep "M" $1 | grep -o -E '[0-9]+') #filters the lines in the text file having F which indicates femail
echo $women
echo $men
#women=$(echo $women); echo "$((${women// /+}))"
#men=$(echo $men); echo "$(($women// /+}))"

echo "The average of the women's age is `echo $women | awk -v RS=' ' '{sum+=$women; count++} END{print sum/count}'`"
echo "The average of the men's age is `echo $men | awk -v RS=' ' '{sum+=$men; count++} END{print sum/count}'`"


