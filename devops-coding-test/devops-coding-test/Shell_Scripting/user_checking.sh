#!/bin/bash

# Check if a command-line argument was provided
if [ $# -eq 0 ]; then
    echo "ERROR: Please provide a user login name as a command-line argument."
    echo "HELP: ./user_checking.sh <username>"
    exit 1
fi

# Get the provided username from the command-line argument
username="$1"

# Check if the user is in the /etc/passwd file
if grep -q "^$username:" /etc/passwd; then
    echo "Found user name in the /etc/passwd file."
else
    echo "ERROR: User name not found."
fi

#executing steps

#chmod +x user_checking.sh
#./user_checking.sh <username>