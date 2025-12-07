<#
.SYNOPSIS
    Convert PNG images to A3 size at 300 dpi.

.DESCRIPTION
    This script processes all PNG files in the current folder (or matching a pattern).
    It resizes proportionally to fit within A3 dimensions (3508x4961 px),
    then extends the canvas with white background to ensure exact A3 size.
    Output files are saved in a dedicated folder.
#>

param(
    [string]$Pattern      = "*.png",     # File pattern
    [string]$OutputFolder = "A3_300dpi"  # Output folder
)

# Target A3 dimensions at 300 dpi
$A3Width  = 3508
$A3Height = 4961
$DPI      = 300

Write-Host "🔧 Converting images to A3 ($A3Width x $A3Height @ $DPI dpi)..."

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

        # Resize proportionally to fit within A3, then extend canvas to exact A3
        magick $fullname `
            -resize "${A3Width}x${A3Height}" `
            -background white -gravity center `
            -extent ${A3Width}x${A3Height} `
            -density $DPI `
            $outFile

        Write-Host "✅ $basename converted → $outFile"
    }

    Write-Host "🎉 All files have been processed and saved in '$OutputFolder'."
}
