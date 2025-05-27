#!/bin/bash
# find full path of script:
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
hydeLibDir="$(dirname $SCRIPT_PATH)/hyde"

source $hydeLibDir/pretty_print.sh
source $hydeLibDir/global_fn.sh

errors=0
album_name="$1"
cwd=$(pwd)
parent_dir=$(pwd | rev | cut --complement -d '/' -f 1 | rev) 

JPG_source="${cwd}/${album_name}/entwickelt"
RAW_source="${cwd}/${album_name}/RAW"

#### CONFIGURATION ####

# Enter path to your RAW files here:
RAW_dest="${cwd}/rawdestination/${album_name}/"

# Enter path to your jpg files here:
JPG_dest="${cwd}/jpgdestination/${album_name}/"

print_message -w "General" "This script will move files from specified album to respective destination."

if [[ -z $1 ]]; then
  print_message -e "Error" "No album as been specified. Please provide an album (foldername) to deploy as argument."
  exit 0
fi

print_message -w "Directories" "The following directories will be used:"
print_message -w "Directories" "JPG destination: $JPG_dest"
print_message -w "Directories" "RAW destination: $RAW_dest"

print_message -w "General" "Are you sure you want to run this script?"
read -p "y/n:" choice

if [[ "$choice" == [yY] ]]; then

		print_message -w "File" "RAW destination: $RAW_dest" 
		print_message -w "File" "JPG destination: $JPG_dest"
		print_message -i "File" "current dir: $cwd"
		print_message -i "File" "parent dir: $parent_dir"
		print_message -i "File" "album name: $album_name"
		mkdir -p "$RAW_dest"
		mkdir -p "$JPG_dest"

		error_handler()
		{
		print_message -e "$1" "$2"
		errors=$(($errors+1))
		}

		mv "${RAW_source}"/* "${RAW_dest}" 2> /dev/null || error_handler "File" "no raw files found. Already deployed?"
		mv "${JPG_source}"/* "${JPG_dest}" 2> /dev/null || error_handler "File" "no jpg files found. Already deployed?"

		if [ $errors -eq 0 ]; then
		print_message -s "General" "Photos have been deployed successfully."
		else 
		print_message -e "General" "Errors have been reported."
		fi
else
		print_message -i "General" "Script interrupted by user."
fi
