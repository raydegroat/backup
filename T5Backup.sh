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
	read -p "Enter the backup file to restore: " restore_files 
	read -p "Enter the path to restore to: " dest
	
	# Print start status message.
	echo "Restoring $restore_files to $dest"
	date
	echo
	# To see the listing of archive contents
	arc_cont=$(tar -tf $restore_files)
	echo "contents of the archive files are: $arc_cont"
	echo
	# Restore the files using tar.
	# Future error hadling and robustness
	#if [ -f "$File" ]; then 
	#	echo "File exists. No need to restore. Abort restoring"
	#	echo
	#else
   	
	# Extract backup files
	tar -xzvf $restore_files -C $dest
   	
	# -C  option to tar redirects the extracted files to the specified directory.
	#fi

	# Print end status message.
	echo
	echo "Restore finished"
	date
	break
fi
done
# Long listing of files in $dest to check file sizes.
ls -lh $dest
