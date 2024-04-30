#!/bin/bash

# Change to the home directory
cd ~/

# Find and remove files matching the specified pattern
find . -name '[a-z][a-z][0-9][0-9].txt' -type f -delete

# execute below commands to run the script ans setup crontab
#Make the shell script executable:
#chmod +x cronjab_entry_matching_pattern.sh

#Open your crontab file for editing:
#crontab -e

#Add the following entry at the end of the crontab file:
#0 2 * * 1 ~/cronjab_entry_matching_pattern.sh