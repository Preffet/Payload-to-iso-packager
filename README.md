## Description

Small powershell script to create ISO payloads by using DLL sideloading
and then LNK file to trigger the payload execution.

## Requirements
Use the ```pip install -r requirements.txt``` command to install all of 
the Python modules and packages listed in your requirements.txt file
Also [PackMyPayload](https://github.com/mgeeky/PackMyPayload) by Mariusz Banach / mgeeky script is used, but it 
is included with the project files, you do not need to install it.

## High-Level Script Overview

1. DLL file, an EXE file, and a LNK file are provided as inputs.
2. Check if the necessary input parameters are provided, and also if the provided LNK
   file has the correct extension.
3. If all inputs are correct, create a shortcut file (.lnk) with the given parameters using
   Windows Script Host (WSH) COM object. This shortcut file opens a command prompt and runs
   the EXE file specified in the parameters.
4. Create two directories if they don't exist yet: "Payloads" and "Output". The former is used to store 
   the input files (DLL, EXE, LNK), and the latter is used to store the output ISO file.
5. Copy the input files (DLL, EXE, LNK) to the "Payloads" directory.
6. After all the files are in place, package these files into an ISO file.
   The files "OneDriveStandaloneUpdater.exe" and "version.dll" (your payload) are hidden in the ISO.
7. If successful, display a message stating that the payload was created successfully, 
   if an error occurs at any point in the process (such as Python or required dependencies not being installed), catch the error and display the error message.

   
## Usage

The OneDriveStandaloneUpdater.exe in the iso file is a real 
binary executing your shellcode (called version.dll)

To run the script, you can use:
'''
.\make-iso.ps1 -dll version.dll -lnk readme.txt.lnk -iso Updates.iso -file OneDriveStandaloneUpdater.exe
'''

- OneDriveStandaloneUpdater.exe is a real Microsoft OneDrive binary. By default it is located at C:\Users\%USERPROFILE%\AppData\Local\Microsoft\OneDrive
- version.dll is your payload script (you have to rename it to "version.dll")
- readme.txt.lnk. This is the LNK file that will trigger the payload process. You can rename it if you wish.
- Updates.iso. This is the final payload containing all pieces, you can rename it if you wish.
