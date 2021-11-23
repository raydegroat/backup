#!/bin/bash
####################################
#
# T5 Backup Script (Based on examples provided by Ubuntu) 
#
####################################

echo "Enter 1 to backup or 2 to restore" # Prompt user to select backup or restore

choice="Backup Restore"

select option in $choice; do
	if [ $REPLY = 1 ];		 # Backup
then
					 # Determin source
	read -p "Enter path of file or directory to backup: " source_file
					 # Determin destination
	read -p "Enter path to backup to: " dest_path

					 # Create an archive name using hostname, 
	day=$(date +%A)			 # day of week, and ending with .tgz
	hostname=$(hostname -s)
	archive_name="$hostname-$day.tgz" 

	echo "Archiving and compressing  $source_file to $dest_path/$archive_name"
	date
	echo
				         # Create a gzip tar archive 
	tar czf $dest_path/$archive_name $source_file

	echo "Encrypting $archive_name"
	echo	 
					 # Encrypt the file using GPG symetric encryption
	gpg -c $dest_path/$archive_name
	
	echo "The file is encrypted. Deleting unencrypted archive..."
	echo
	rm -f $dest_path/$archive_name
	echo "Backup and encrypt complete!"
	date
	break
else					 # Restore - Determin source and destination
	read -p "Enter path to encrypted backup file to restore from: " restore_file 
	read -p "Enter the path to restore to: " dest_path

	echo "Decrypting $restore_file to $dest_path"
	date
	echo
					 # Decrypt file
	gpg -d --output $dest_path/temp_decrypted.tgz $restore_file
	
	echo "File decrypted"
	echo
	
	# Future error handling for robustness
	# To see the listing of archive contents
	# arc_cont=$(tar -tf $restore_files)
	# echo "contents of the archive files are: $arc_cont"
	# Restore the files using tar.
	#if [ -f "$File" ]; then 
	#	echo "File exists. No need to restore. Abort restoring"
	#	echo
	#else
	#fi

	echo "Unarchiving..."
	echo  	
					 # Extract backup files using -C to direct 
					 # files to specified directory.
	tar -xzvf $dest_path/temp_decrypted.tgz -C $dest_path
   	
	echo "Unarchive complete!"
	echo
	echo "Cleaning up..."
	echo 
	echo "Restore finished."
	date
	break
fi
done
# Long listing of files in $dest to check file sizes.
ls -lh $dest_path
