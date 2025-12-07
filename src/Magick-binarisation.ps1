<#
.SYNOPSIS
    Batch convert images to pure black and white (binarization).

.DESCRIPTION
    This script processes all images in the current folder that match a given pattern.
    It applies ImageMagick's -threshold operation to convert them into pure black and white
    (no grayscale). Useful for scanned documents or high-contrast artwork.

.PARAMETER Pattern
    File pattern to process (e.g. "*.png", "*.jpg"). Default: "*.png".

.PARAMETER Threshold
    Threshold value (0–100). Pixels darker than this value become black,
    pixels lighter become white. Default: 50.
    ⚡ If a value <0 is given, it is reset to 0.
    ⚡ If a value >100 is given, it is reset to 100.

.PARAMETER OutputFolder
    Folder where binarized images will be saved. Default: "Binarized".

.EXAMPLE
    .\Magick-binarisation.ps1
    Converts all PNG files in the current folder to black and white using a threshold of 50%.

.EXAMPLE
    .\Magick-binarisation.ps1 -Threshold 70 -Pattern "*.jpg"
    Converts all JPG files with a threshold of 70% (more aggressive binarization).

.NOTES
    Author: VincentD
    Version: 1.1
    Date: 12/05/2025
    License: This script is provided "as is" without warranty.
             Free to use for personal or professional purposes.
    Compatible with PowerShell 5.1 and later.
#>

# ==============================
# Script start
# ==============================

param(
    [string]$Pattern      = "*.png",     # File pattern
    [int]$Threshold       = 50,          # Threshold (0–100)
    [string]$OutputFolder = "Binarized"  # Output folder
)

# Clamp threshold between 0 and 100
if ($Threshold -lt 0) { $Threshold = 0 }
if ($Threshold -gt 100) { $Threshold = 100 }

Write-Host "Applying binarization with threshold=$Threshold%..."

# Create output folder if needed
if (!(Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
    Write-Host "📂 Folder '$OutputFolder' created."
}

# Get files
$files = Get-ChildItem -Filter $Pattern

if ($files.Count -eq 0) {
    Write-Host "⚠️ No files found with pattern '$Pattern'."
} else {
    foreach ($file in $files) {
        $fullname = $file.FullName
        $basename = $file.BaseName
        $outFile  = Join-Path $OutputFolder ($basename + ".png")

        Write-Host "Processing $basename..."

        # Apply binarization
        magick $fullname -threshold ${Threshold}% $outFile

        Write-Host "✅ $basename binarized → $outFile"
    }

    Write-Host "✅ All files have been processed and saved in '$OutputFolder'."
}
