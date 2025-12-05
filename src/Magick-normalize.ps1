<#
.SYNOPSIS
    Batch normalize images (DPI).

.DESCRIPTION
    This script processes all images in the current folder that match a given pattern.
    It creates a subfolder (default: "Normalized") and saves the processed images there
    with a fixed DPI value (default: 300). Different DPI values can cause issues when
    combining images into a PDF. Normalizing ensures consistency.

.PARAMETER Pattern
    File pattern to process (e.g. "*.png", "*.jpg"). Default: "*.png".

.PARAMETER Dpi
    Target DPI value. Default: 300.

.PARAMETER OutputFolder
    Output folder where normalized images will be saved. Default: "Normalized".

.EXAMPLE
    .\Magick-normalize.ps1
    Normalizes all PNG files in the current folder to 300 DPI and saves them in "Normalized".

.EXAMPLE
    .\Magick-normalize.ps1 -Pattern "*.jpg" -Dpi 150 -OutputFolder "Out"
    Normalizes all JPG files to 150 DPI and saves them in the "Out" folder.

.NOTES
    Author: VincentD
    Version: 1.0
    Date: 12/05/2025
    License: This script is provided "as is" without warranty.
             Free to use for personal or professional purposes.
    Compatible with PowerShell 5.1 and later.
#>

# ==============================
# Script start
# ==============================

param(
    [string]$Pattern      = "*.png",     # File pattern (default: PNG files)
    [int]$Dpi             = 300,         # Target DPI value (default: 300)
    [string]$OutputFolder = "Normalized" # Output folder (default: "Normalized")
)

# Clamp DPI between 72 and ????
if ($DPI -lt 72) { $DPI = 72 }
#if ($DPI -gt 600) { $DPI = 600 }


Write-Host "Normalizing images to ${Dpi} DPI..."

# Create the output folder if it does not exist
if (!(Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
    Write-Host "📂 Folder '$OutputFolder' created."
}

# Get all files matching the pattern
$files = Get-ChildItem -Filter $Pattern

if ($files.Count -eq 0) {
    Write-Host "⚠️ No files found with pattern '$Pattern'."
} else {
    foreach ($file in $files) {
        $fullname = $file.FullName
        $basename = $file.BaseName
        $outFile  = Join-Path $OutputFolder ($basename + ".png")

        Write-Host "Processing $basename..."

        # Normalize DPI only (no resize)
        magick $fullname -units PixelsPerInch -density ${Dpi}x${Dpi} $outFile

        Write-Host "✅ $basename normalized to ${Dpi} DPI → $outFile"
    }

    Write-Host "✅ All files have been processed and saved in '$OutputFolder'."
}
