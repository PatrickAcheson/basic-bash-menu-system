#!/bin/bash

clear
echo "MUOS Bash Script Menu"
# Sets loop value to yes
loop=yes

# Loops entire script until loop variable != yes or is broken
while [[ $loop == yes ]]; do
    # Displays to screen menu selection to user
    echo "
	-------------------------------------
	Please Select:
	1. Back up a script file
	2. Create Stamped Log-File
	3. Copy File to Custom Directory
	4. Move File to Custom Directory
	0. Quit
	-------------------------------------
    "
    # Reads User input
    read -p "Enter selection [0-4] > "
    # Checks if User input is between 0 and 4
    if [[ $REPLY =~ ^[0-4]$ ]]; then
        # Check variable and exits if true
        if [[ $REPLY == 0 ]]; then
            loop=no
            echo "Program terminated!"
            exit
        fi
        # Checks if input value then prints option name
        if [[ $REPLY == 1 ]]; then
            echo "        -------------------------------------"
            echo "SCRIPT-FILE-BACKUP"
            # Starts nested loop reads in user input and saves it as scriptname variable
            while true ; do
                echo "Enter the name of the script: "
                read scriptname
                # Check if a filed exists with the name of the input then breaks the loop
                if [ -f "$scriptname" ]; then
                    echo " "
                    echo "The file $scriptname exists. "
                    break
                # Loops until a valid file name is selected
                else
                    echo "Script name is doesn't exist."
                fi
            done
            # Sends to screen text and default location of backup directory
            echo "Creating Backup..."
            echo "Location: /home"
            # Creates a copy of filename varible, copies the file to /home and appends "_backup_" with current date on the end
            cp ./$scriptname /home/"$scriptname"_backup_"$(date +%F)"
        fi
        # Creates a file called log_file and appends current date on the end then appends, users logged in, diskusage and current processes
        if [[ $REPLY == 2 ]]; then
            echo "        -------------------------------------"
            w > /home/log_dir/log_file_$(date +%F)
            du >> /home/log_dir/log_file_$(date +%F)
            ps >> /home/log_dir/log_file_$(date +%F)
            # Sends to screen location
            echo "Saved to: /home/log_dir"
        fi
        # Starts loop and checks if the file name exists
        if [[ $REPLY == 3 ]]; then
            echo "        -------------------------------------"
            while true ; do
                echo "FILE-COPY-FUNCTION"
                echo "Enter the file name: "
                read filename
                if [ -f "$filename" ]; then
                    echo " "
                    echo "The file exists."
                    break
                # Loops until correct file name is entered
                else
                    echo "File doesn't exist. Enter Again"
                fi
            done
            # Prompts user for a directory to copy the file too
            while true ; do
                echo "Enter the directory to COPY $filename too: "
                echo "example: home/test"
                read directoryname
                # If the directory exist the nested loop breaks
                if [ -d /"$directoryname" ]; then
                    echo " "
                    echo "The directory $directoryname exists. Ready to copy file"
                    break
                # If directory does not exist loop continues
                else
                    echo "Directory doesn't exist. Enter Again."
                fi
            done
            # Copies the file to the destination using both varibles
            echo " "
            echo "Copying..."
            cp /home/kali/Desktop/$filename /$directoryname/$filename
        fi
        # Simlair fuctionality to above although the file is moved apose to copy
        if [[ $REPLY == 4 ]]; then
            echo "FILE-MOVE-FUNCTION"
            while true ; do
                echo "Enter the file name: "
                read filename
                # Validates file name then breaks if met
                if [ -f "$filename" ]; then
                    echo " "
                    echo "The file $filename exists. "
                    break
                # Loops until conditon is met
                else
                    echo "File doesn't exist. Enter Again"
                fi
            done
            # After condition is met it will ask for the directory like above
            while true ; do
                echo "Enter the directory to MOVE $filename too: "
                echo "example: home/test"
                read directoryname
                if [ -d /"$directoryname" ]; then
                    echo " "
                    echo "The directory $directoryname exists. Ready to move file"
                    break
                else
                    echo "Directory doesn't exist. Enter Again"
                fi
            done
            # Once both conditions are met the file is moved using both $ variables
            echo " "
            echo "Moving..."
            mv ./$filename /$directoryname/$filename
        fi
    # When input is not between 0 and 4 this message is shown until the condition is met    
    else
        echo "        -------------------------------------"
        echo "Invalid entry. Enter from 0 - 4" >&2
    fi
done
