# Week 2 Tasks

Write a bash script that takes the file ***users.txt*** as input and prints out the average age of male and average age of female.

 * Line 1 contains the SheBang command which is the absolute path to the Bash interpreter and specifies which program should be called to run the script.
 * Line 3 assigns the filename as the first command-line argument passed to the shell script.

 * In Lines 5 and 6, used the grep and egrep command to filter the each line in the text file and return only the integers therein and outputted the input as vairables **women** and **men** respectively

* In Lines 8 and 9, we used echo $variable to verify that we have the right output.
 * In lines 11 and 12, we used the awk command to add the numbers and divide the sum by count(number of the integers) and print the result.
 * The result is returned in a string format.

 * The script can be run like this **./bash.sh users.txt**