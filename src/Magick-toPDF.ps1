<#
.SYNOPSIS
    Combine images into a single PDF.

.DESCRIPTION
    This script takes all images in the current folder that match a given pattern
    and merges them into one PDF file using ImageMagick. Useful when you need a
    multi-page PDF from a sequence of images without manual work.

.PARAMETER Pattern
    File pattern to include (e.g. "*.png", "*.jpg"). Default: "*.png".

.PARAMETER OutputPDF
    Output PDF file name. Default: "output.pdf".

.EXAMPLE
    .\Magick-toPDF.ps1
    Combines all PNG files in the current folder into "output.pdf".

.EXAMPLE
    .\Magick-toPDF.ps1 -Pattern "*.jpg" -OutputPDF "photos.pdf"
    Combines all JPG files in the current folder into "photos.pdf".

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
    [string]$Pattern   = "*.png",     # File pattern (default: PNG files)
    [string]$OutputPDF = "output.pdf" # Output PDF file name
)

Write-Host "Combining images into PDF..."

# Run ImageMagick to merge all files into one PDF
magick $Pattern $OutputPDF

Write-Host "✅ PDF generated: $OutputPDF"
