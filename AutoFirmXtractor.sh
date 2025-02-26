#!/bin/bash


# Display Tool Name and Description
# echo "Tool Name: AutoFirmXtractor"
echo "AutoFirmXtractor is a Firmware Data Extraction Tool that will automatically extract data from any firmware file."

# Function to display help
usage() {
  echo "Tool Usage: $0 -f [firmware_file] -p [prefix]"
  echo " -f [firmware_file] Path to the Firmware File"
  echo " -p [prefix]        Provide the Firmware Name itself as Prefix for the output files generation"
  exit 0
}

# Parse command-line arguments
while getopts "f:p:" opt; do
  case $opt in
    f) firmware_file="$OPTARG" ;;
    p) prefix="$OPTARG:" ;;
    *) usage ;;
  esac
done

# Check if firmware file and prefix are provided
if [ -z "$firmware_file" ] || [ -z "$prefix" ]; then
#  echo "Error: Both firmware file and prefix must be provided."
  usage
fi


# Check if the firmware file exists
if [ ! -f "$firmware_file" ]; then
  echo "Error: Firmware file '$firmware_file' does not exist."
  exit 1
fi

# Script Logic Starts 
echo "Firmware Data Extraction Processes Initiated......"

# Define commands and their respective short forms
commands=(
  "file $firmware_file" 
# "strings $firmware_file"
# "strings -n16 $firmware_file"
# "strings -tx $firmware_file"
  "strings $firmware_file | grep pass"
  "strings $firmware_file | grep user"
  "strings $firmware_file | grep token"
  "strings $firmware_file | grep api"
  "strings $firmware_file | grep psk"
  "strings $firmware_file | grep crt"
  "strings $firmware_file | grep pem"
  "strings $firmware_file | grep conf"
  "strings $firmware_file | grep cer"
  "strings $firmware_file | grep p7b"
  "strings $firmware_file | grep p12"
  "strings $firmware_file | grep key"
  "strings $firmware_file | grep auth"
  "strings $firmware_file | grep host"
  "strings $firmware_file | grep id_rsa"
  "strings $firmware_file | grep pub"
  "strings $firmware_file | grep db"
  "strings $firmware_file | grep sql"
  "strings $firmware_file | grep sh"
  "strings $firmware_file | grep bin"
  "strings $firmware_file | grep admin"
  "strings $firmware_file | grep root"
  "strings $firmware_file | grep shadow"
  "fdisk -lu $firmware_file" 
  "sha256sum $firmware_file"
  "hexdump -C $firmware_file" 
  "hexdump -C -n 160 $firmware_file" 
  "binwalk $firmware_file -v" 
  "binwalk -S $firmware_file -v" 
  "binwalk -eM $firmware_file -v" 
  "binwalk --dd='.*' $firmware_file -v"
  "binwalk -E $firmware_file" 
)

shortforms=(
  "file"
#  "str"
# "strn16"
# "strtx"
  "spass"
  "suser"
  "stoken"
  "sapi"
  "spsk"
  "scrt"
  "spem"
  "sconf"
  "scer"
  "sp7b"
  "sp12"
  "skey"
  "sauth"
  "shost"
  "sidrsa"
  "spub"
  "sdb"
  "ssql"
  "ssh"
  "sbin"
  "sadmin"
  "sroot"
  "sshadow"
  "fdisk"
  "sha256"
  "hex"
  "hexhead"
  "bwv"
  "bwSv"
  "bwemv"
  "bwdd"
  "bwE"
)

# List of commands that should display their output to the terminal
display_on_terminal=(
  "file $firmware_file" 
  "strings $firmware_file | grep pass"
  "strings $firmware_file | grep user"
  "strings $firmware_file | grep token"
  "strings $firmware_file | grep api"
  "strings $firmware_file | grep psk"
  "strings $firmware_file | grep crt"
  "strings $firmware_file | grep pem"
  "strings $firmware_file | grep conf"
  "strings $firmware_file | grep cer"
  "strings $firmware_file | grep p7b"
  "strings $firmware_file | grep p12"
  "strings $firmware_file | grep key"
  "strings $firmware_file | grep auth"
  "strings $firmware_file | grep host"
  "strings $firmware_file | grep id_rsa"
  "strings $firmware_file | grep pub"
  "strings $firmware_file | grep db"
  "strings $firmware_file | grep sql"
  "strings $firmware_file | grep sh"
  "strings $firmware_file | grep bin"
  "strings $firmware_file | grep admin"
  "strings $firmware_file | grep root"
  "strings $firmware_file | grep shadow"
  "fdisk -lu $firmware_file"
  "sha256sum $firmware_file"
  "hexdump -C -n 160 $firmware_file"
  "binwalk $firmware_file -v"
  "binwalk -S $firmware_file -v"
  "binwalk -eM $firmware_file -v"
  "binwalk --dd='.*' $firmware_file -v"
  "binwalk -E $firmware_file"
)

# Loop through the commands and execute each one, saving the output to respective files
for i in "${!commands[@]}"; do
  # Get the full command and short form
  cmd="${commands[$i]}"
  shortform="${shortforms[$i]}"
  
  # Create the output file name with the user-defined prefix and short form
  output_file="${prefix}_${shortform}_output.txt"
  
  # If the command is in the display_on_terminal list, display output on terminal and save to file
  if [[ " ${display_on_terminal[@]} " =~ " ${cmd} " ]]; then
    echo "Running: $cmd"
    echo "=============================="
    if [[ "$cmd" == *"| grep"* ]]; then
      bash -c "$cmd"  # Execute pipe commands via bash -c
    else
      $cmd  # For other commands
    fi
    echo "Saving output to: $output_file"
    echo "=============================="
    if [[ "$cmd" == *"| grep"* ]]; then
      bash -c "$cmd" > "$output_file" 2>&1  # Save the output for pipe commands
    else
      $cmd > "$output_file" 2>&1  # Save output for other commands
    fi
    echo "" >> "$output_file"  # Add a blank line at the end of the file
  else
    # For commands not in the display_on_terminal list, only save output to file
    echo "Running: $cmd"
    if [[ "$cmd" == *"| grep"* ]]; then
      bash -c "$cmd" > "$output_file" 2>&1  # Save output for pipe commands
    else
      $cmd > "$output_file" 2>&1  # Save output for other commands
    fi
    echo "" >> "$output_file"  # Add a blank line at the end of the file
    echo "Output saved to: $output_file"
    echo "=============================="
  fi
done

# Done message
echo "All outputs have been saved in respective text files. Firmware Data Extraction Processes Completed Successfully. Done...!"
