#!/bin/bash

echo "A simple file encrypter/decrypter"

echo "Select what you want to do"

choice="Encryption Decryption"

select option in $choice; do
	if [ $REPLY = 1 ];
then
	echo "Enter the file name to encrypt"
	read file;
	gpg -c $file
	echo "The file is encrypted"
else
	echo "Enter the file name to decrypt"
	read file2;
	gpg $file2
	echo "The is decrypted" 
fi

done

