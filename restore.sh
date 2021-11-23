#!/bin/bash
####################################
#
# Restore the files to the different location.
#
####################################

# What to restore.
#read -p "Enter the backup files name with path to restore: " restore_files 
restore_files="/home/anwar/localhost-*"

# Where to restore to.
#read -p "Enter the path where to restore: " dest
dest="/home/anwar/backup_program"


# Print start status message.
echo "Restoring $restore_files to $dest"
date
echo

# To see the listing of archive contents
arc_cont=$(tar -tf $restore_files)
echo "contents of the archive files are: $arc_cont"
echo

# Restore the files using tar.
File=/home/anwar/backup_program/test.txt
if [ -f "$File" ]; then
   echo "File exists. No need to restore. Abort restoring"
   echo
else
   tar -xzvf $restore_files -C $dest
   # -C  option to tar redirects the extracted files to the specified directory.
fi

# Print end status message.
echo
echo "Restore finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
