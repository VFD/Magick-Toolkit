<#
.SYNOPSIS
    Batch convert images to grayscale.

.DESCRIPTION
    This script processes all images in the current folder that match a given pattern
    and converts them to grayscale using ImageMagick.

.PARAMETER Pattern
    File pattern to process (e.g. "*.png", "*.jpg"). Default: "*.png".

.PARAMETER OutputFolder
    Folder where grayscale images will be saved. Default: "Grayscale".

.EXAMPLE
    .\Magick-grey.ps1
    Converts all files (depend on pattern) in the current folder to grayscale and saves them in "Grayscale".
#>

param(
    [string]$Pattern      = "*.png",    # File pattern
    [string]$OutputFolder = "Grayscale" # Output folder
)

Write-Host "Converting images to grayscale..."

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

        # Convert to grayscale
        magick $fullname -colorspace Gray $outFile

        Write-Host "✅ $basename converted → $outFile"
    }

    Write-Host "✅ All files have been processed and saved in '$OutputFolder'."
}
