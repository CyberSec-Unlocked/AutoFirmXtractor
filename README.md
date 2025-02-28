# Description

 AutoFirmXtractor is a firmware data extraction automation tool script, which can be used during static firmware vulnerability 
 assessments.

# Features

- Provides output results using predefined strings and grep combination commands 
- Firmware Extraction

# Prerequisite

 Binwalk tool

# Installation
```
git clone https://github.com/CyberSec-Unlocked/AutoFirmXtractor.git

chmod +x AutoFirmXtractor.sh
```

# Usage
```
./AutoFirmXtractor.sh -f [firmware_file] -p [prefix]

-f [firmware_file] Path to the Firmware File

-p [prefix]        Provide the Firmware Name itself as Prefix for the output files generation
```
