<#
.SYNOPSIS
    Split images vertically into two halves.

.DESCRIPTION
    This script processes all images in the current folder that match a given pattern.
    Each image is cropped vertically into two halves (left and right) and saved into
    a specified output folder. Useful for preparing scanned double-page documents
    or splitting wide images into separate parts.

.PARAMETER Pattern
    File pattern to process (e.g. "*.png", "*.jpg"). Default: "*.png".

.PARAMETER SplitDir
    Output folder where cropped images will be saved. Default: "split".

.EXAMPLE
    .\Magick-split.ps1
    Splits all PNG files in the current folder into halves and saves them in the "split" folder.

.EXAMPLE
    .\Magick-split.ps1 -Pattern "*.jpg" -SplitDir "output"
    Splits all JPG files and saves them in the "output" folder.

.NOTES
    Author: VincentD
    Version: 1.0
    Date: 02/12/2025
    License: This script is provided "as is" without warranty.
             Free to use for personal or professional purposes.
    Compatible with PowerShell 5.1 and later.
#>

# ==============================
# Script start
# ==============================

param(
    [string]$Pattern = "*.png",  # File pattern (default: PNG files)
    [string]$SplitDir = "split"  # Output folder (default: "split")
)

# Create output folder if it does not exist
if (-not (Test-Path $SplitDir)) {
    Write-Host "⚠️ Output folder not found, creating '$SplitDir'."
    New-Item -ItemType Directory -Path $SplitDir | Out-Null
}

# Get files matching the pattern
$files = Get-ChildItem -Filter $Pattern

if ($files.Count -eq 0) {
    Write-Host "⚠️ No files found with pattern '$Pattern'."
} else {
    foreach ($file in $files) {
        $basename = $file.BaseName
        $fullname = $file.FullName

        # Crop vertically into two halves and save in output folder
        magick $fullname -crop 50%x100% +repage (Join-Path $SplitDir "$basename`_split.png")

        Write-Host "Crop done for $basename"
    }

    Write-Host "✅ Processing complete. Cropped files are in '$SplitDir'."
}
