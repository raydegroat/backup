#!/bin/bash
####################################
#
# T5 Backup Script (Based on examples provided by Ubuntu) 
#
####################################

# What to backup. --Anwar added
read -p "Enter the files or folders with path to backup: " backup_files

# Where to backup to. -- Anwar added
read -p "Enter the destination path where to backup to: " dest

# Create archive filename.
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup the files using tar.
tar czf $dest/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
