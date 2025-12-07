<#
.SYNOPSIS
    Batch convert JPG images to PNG using ImageMagick.

.DESCRIPTION
    This script processes all JPG files in the current folder (or matching a pattern)
    and converts them to PNG format. Output files are saved in a dedicated folder.

.PARAMETER Pattern
    File pattern to process (default: "*.jpg").

.PARAMETER OutputFolder
    Folder where PNG images will be saved (default: "ConvertedPNG").

.EXAMPLE
    .\Magick-jpg2png.ps1
    Converts all JPG files in the current folder to PNG.

.EXAMPLE
    .\Magick-jpg2png.ps1 -Pattern "*.jpeg" -OutputFolder "PNG"
    Converts all JPEG files to PNG and saves them in "PNG".
#>

param(
    [string]$Pattern      = "*.jpg",       # File pattern
    [string]$OutputFolder = "ConvertedPNG" # Output folder
)

Write-Host "🔧 Converting JPG to PNG..."

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

        # Convert JPG to PNG
        magick $fullname $outFile

        Write-Host "✅ $basename converted → $outFile"
    }

    Write-Host "✅ All files have been converted and saved in '$OutputFolder'."
}
