<#
.SYNOPSIS
    Batch adjust image levels (Photoshop-style 0–255 values).

.DESCRIPTION
    This script processes all images in the current folder that match a given pattern.
    It applies ImageMagick's -level operation using Photoshop-style values:
    Black (0–255), White (0–255), and Gamma (float).
    Useful for batch correction of scanned images or photos.

.PARAMETER Pattern
    File pattern to process (e.g. "*.png", "*.jpg"). Default: "*.png".

.PARAMETER Black
    Black point (0–255). Default: 0.

.PARAMETER White
    White point (0–255). Default: 255.

.PARAMETER Gamma
    Gamma correction (midtones). Default: 1.0.

.PARAMETER OutputFolder
    Folder where adjusted images will be saved. Default: "Leveled".

.EXAMPLE
    .\Magick-level.ps1
    Adjusts all PNG files with default levels (Black=0, White=255, Gamma=1.0).

.EXAMPLE
    .\Magick-level.ps1 -Black 10 -White 240 -Gamma 1.2 -Pattern "*.jpg"
    Adjusts JPG files with black at 10, white at 240, gamma 1.2.

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
    [string]$Pattern      = "*.png",   # File pattern
    [int]$Black           = 0,         # Black point (0–255)
    [int]$White           = 255,       # White point (0–255)
    [double]$Gamma        = 1.0,       # Gamma correction (0.1-5.0)
    [string]$OutputFolder = "Leveled"  # Output folder
)

# Clamp black between 0 and 255
if ($Black -lt 0) { $Black = 0 }
if ($Black -gt 255) { $Black = 255 }

# Clamp White between 0 and 255
if ($White -lt 0) { $White = 0 }
if ($White -gt 255) { $White = 255 }

# Clamp gamma between 0.1 and 5.0
if ($Gamma -lt 0.1) { $Gamma = 0.1 }
if ($Gamma -gt 5.0) { $Gamma = 5.0 }


Write-Host "Applying level adjustment: Black=$Black, White=$White, Gamma=$Gamma"

# Convert Photoshop-style values (0–255) to percentages for ImageMagick
$blackPercent = [math]::Round(($Black / 255.0) * 100, 2)
$whitePercent = [math]::Round(($White / 255.0) * 100, 2)

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

        # Apply level adjustment with converted values
        magick $fullname -level ${blackPercent}%,${whitePercent}%,${Gamma} $outFile

        Write-Host "✅ $basename adjusted → $outFile"
    }

    Write-Host "✅ All files have been processed and saved in '$OutputFolder'."
}
