<#
.SYNOPSIS
    Convert PNG images to A4 size at 300 dpi.

.DESCRIPTION
    This script processes all PNG files in the current folder (or matching a pattern).
    It resizes proportionally to fit within A4 dimensions (2480x3500 px),
    then extends the canvas with white background to ensure exact A4 size.
    Output files are saved in a dedicated folder.

.PARAMETER Pattern
    File pattern to process (default: "*.png").

.PARAMETER OutputFolder
    Folder where converted images will be saved (default: "A4_300dpi").

.EXAMPLE
    .\Magick-toA4.ps1
    Converts all PNG files to A4 at 300 dpi.
#>

param(
    [string]$Pattern      = "*.png",     # File pattern
    [string]$OutputFolder = "A4_300dpi"  # Output folder
)

# Target A4 dimensions at 300 dpi
$A4Width  = 2480
$A4Height = 3508
$DPI      = 300

Write-Host "🔧 Converting images to A4 ($A4Width x $A4Height @ $DPI dpi)..."

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

        # Resize proportionally to fit within A4, then extend canvas to exact A4
        magick $fullname `
            -resize "${A4Width}x${A4Height}" `
            -background white -gravity center `
            -extent ${A4Width}x${A4Height} `
            -density $DPI `
            $outFile

        Write-Host "✅ $basename converted → $outFile"
    }

    Write-Host "✅ All files have been processed and saved in '$OutputFolder'."
}
