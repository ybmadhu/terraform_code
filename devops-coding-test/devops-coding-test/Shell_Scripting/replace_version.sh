#!/bin/bash

# File path
file_path="/tmp/version.txt"

# Check if the file exists
if [ ! -f "$file_path" ]; then
    echo "ERROR: File $file_path not found."
    exit 1
fi

# Perform the replacement using sed
sed -i 's/2\.1\.1/2_1_1/g' "$file_path"

echo "Occurrences of '2.1.1' replaced with '2_1_1' in $file_path."

# run the below commands to execute
#chmod +x replace_version.sh
#./replace_version.sh
