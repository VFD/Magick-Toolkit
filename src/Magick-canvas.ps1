<#
.SYNOPSIS
    Batch adjust image dimensions.

.DESCRIPTION
    This script processes all images in the current folder that match a given pattern.
    It adjusts each image to fit a defined canvas size, centering the image and filling
    the background if needed. Useful when images have different sizes and you want them
    standardized for further processing.

.PARAMETER CanvasWidth
    Canvas width in pixels. Default: 950.

.PARAMETER CanvasHeight
    Canvas height in pixels. Default: 1500.

.PARAMETER Background
    Background color used to fill empty space. Options: "white", "transparent", or any valid color.
    Default: "white".

.PARAMETER Pattern
    File pattern to process (e.g. "*.png", "*.jpg"). Default: "*.png".

.EXAMPLE
    .\Magick-canvas.ps1
    Adjusts all PNG files to fit a 950x1500 canvas with a white background.

.EXAMPLE
    .\Magick-canvas.ps1 -CanvasWidth 1920 -CanvasHeight 1080 -Background transparent -Pattern "*.jpg"
    Adjusts all JPG files to fit a 1920x1080 canvas with a transparent background.

.NOTES
    Author: VincentD
    Version: 1.0
    Date: 12/02/2025
    License: This script is provided "as is" without warranty.
             Free to use for personal or professional purposes.
    Compatible with PowerShell 5.1 and later.
#>

# ==============================
# Script start
# ==============================

param(
    [int]$CanvasWidth  = 950,          # Canvas width in pixels
    [int]$CanvasHeight = 1500,         # Canvas height in pixels
    [string]$Background = "white",     # Background color ("white" or "transparent")
    [string]$Pattern    = "*.png"      # File pattern to process
)

# Clamp to avoid problems, you can change it if you want

# Clamp CanvasWidth between 100 and 10000
if ($CanvasWidth -lt 100) { $CanvasWidth = 100 }
if ($CanvasWidth -gt 10000) { $CanvasWidth = 10000 }

# Clamp CanvasHeight between 100 and 10000
if ($CanvasHeight -lt 100) { $CanvasHeight = 100 }
if ($CanvasHeight -gt 10000) { $CanvasHeight = 10000 }

Write-Host "Canvas set to ${CanvasWidth}x${CanvasHeight} pixels."

# Get files matching the pattern
$files = Get-ChildItem -Filter $Pattern

if ($files.Count -eq 0) {
    Write-Host "⚠️ No files found with pattern '$Pattern'."
} else {
    foreach ($file in $files) {
        $fullname = $file.FullName
        $basename = $file.BaseName

        Write-Host "Processing $basename..."

        # Adjust canvas: centers the image and adds background if smaller
        magick $fullname -background $Background -gravity center -extent ${CanvasWidth}x${CanvasHeight} $fullname

        Write-Host "✅ $basename adjusted to canvas ${CanvasWidth}x${CanvasHeight} with background $Background."
    }

    Write-Host "✅ All files have been processed."
}
