#!/bin/bash
####################################
#
# T5 Backup Script (Based on examples provided by Ubuntu) 
#
####################################

echo "Enter 1 to backup or 2 to restore"

choice="Backup Restore"

select option in $choice; do
	if [ $REPLY = 1 ];
then
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

	gpg -c $dest/$archive_file
	

	echo "The file is encrypted" # Script should first verify sucess  before echoing 
	# Print end status message.
	echo
	echo "Backup finished"
	date
	break
else
	echo "Enter file to restore"
	break
fi
done
# Long listing of files in $dest to check file sizes.
ls -lh $dest
