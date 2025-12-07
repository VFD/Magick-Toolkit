<#
.SYNOPSIS
    Batch rename files with sequential numbering.

.DESCRIPTION
    Renames all files in the current folder that match a given pattern.
    Each file is renamed with a constant base name followed by a sequential
    number (zero-padded to a configurable number of digits) and the original extension.
    Useful for preparing ordered files such as pages for a PDF or image sequence.

.PARAMETER StartNumber
    Starting number for the sequence. Default: 1.

.PARAMETER Increment
    Increment step between numbers. Default: 1.

.PARAMETER OutputBase
    Constant base name for output files. Default: "Page".

.PARAMETER Pattern
    File pattern to process (e.g. "*.png", "*.jpg"). Default: "*.*".

.PARAMETER Digits
    Number of digits for zero-padding. Default: 3.

.EXAMPLE
    .\Magick-renum.ps1
    Renames all files in the current folder with names like Page_001.png, Page_002.png, etc.

.EXAMPLE
    .\Magick-renum.ps1 -StartNumber 10 -Increment 2 -OutputBase "Image" -Pattern "*.jpg" -Digits 4
    Renames JPG files starting at 10, incrementing by 2, with names like Image_0010.jpg, Image_0012.jpg, etc.

.NOTES
    Author: VincentD
    Version: 1.1
    Date: 12/05/2025
    Compatible with PowerShell 5.1 and later.
    License: This script is provided "as is" without warranty.
             Free to use for personal or professional purposes.
#>

# ==============================
# Script start
# ==============================

param(
    [int]$StartNumber = 0,        # Starting number (default: 1)
    [int]$Increment   = 1,        # Increment step between numbers
    [string]$OutputBase = "Page", # Constant base name for output files
    [string]$Pattern     = "*.*", # File pattern to process
    [int]$Digits      = 3         # Number of digits for zero-padding (default: 3)
)

# Get files sorted by name
$files = Get-ChildItem -Filter $Pattern | Sort-Object Name

if ($files.Count -eq 0) {
    Write-Host "⚠️ No files found with pattern '$Pattern'."
} else {
    $counter = $StartNumber
    foreach ($file in $files) {
        $ext = $file.Extension
        # Build new name: BaseName + sequential number (zero-padded) + extension
        $newName = "{0}{1:D$Digits}{2}" -f $OutputBase, $counter, $ext

        Write-Host "Renaming: $($file.Name) → $newName"

        # Perform the rename
        Rename-Item -Path $file.FullName -NewName $newName

        # Increase counter by increment
        $counter += $Increment
    }

    Write-Host "✅ All files have been renamed."
}
