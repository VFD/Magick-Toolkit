<#
.SYNOPSIS
    Generate a blank image with ImageMagick.

.DESCRIPTION
    This script creates a PNG image with fixed dimensions.
    The image can be white, transparent, or a custom RGB color
    depending on the selected type. Useful for generating placeholder
    images or standardized backgrounds for further processing.

.PARAMETER Height
    Height of the image in pixels. Default: 1080.

.PARAMETER Width
    Width of the image in pixels. Default: 1920.

.PARAMETER Type
    Type of image to generate:
      1 = White
      2 = Transparent
      3 = RGB color (defined by -Color).
    Default: 1.

.PARAMETER Color
    RGB color value used when Type = 3.
    Format: "rgb(R,G,B)" (e.g. "rgb(255,0,0)" for red).
    Default: "rgb(255,0,0)".

.PARAMETER Output
    Output file name. Default: "blank.png".

.EXAMPLE
    .\Magick-create.ps1
    Generates a white PNG image of 1920x1080 pixels named "blank.png".

.EXAMPLE
    .\Magick-create.ps1 -Type 2 -Output "transparent.png"
    Generates a transparent PNG image named "transparent.png".

.EXAMPLE
    .\Magick-create.ps1 -Type 3 -Color "rgb(0,255,0)" -Output "green.png"
    Generates a green PNG image named "green.png".

.EXAMPLE
    .\Magick-create.ps1 -Width 800 -Height 600 -Type 1 -Output "small.png"
    Generates a white PNG image of 800x600 pixels named "small.png".

.EXAMPLE
    .\Magick-create.ps1 -Width 1024 -Height 768 -Type 3 -Color "rgb(0,0,255)" -Output "blue.png"
    Generates a blue PNG image of 1024x768 pixels named "blue.png".

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
    [int]$Height = 1080,              # Height in pixels (default: 1080)
    [int]$Width  = 1920,              # Width in pixels (default: 1920)
    [int]$Type   = 1,                 # 1 = White, 2 = Transparent, 3 = RGB
    [string]$Color = "rgb(255,0,0)",  # RGB color (used if Type = 3)
    [string]$Output = "blank.png"     # Output file name
)

switch ($Type) {
    1 {
        # White image
        magick -size ${Width}x${Height} xc:white $Output
        Write-Host "✅ White image generated: $Output"
    }
    2 {
        # Transparent image
        magick -size ${Width}x${Height} xc:none $Output
        Write-Host "✅ Transparent image generated: $Output"
    }
    3 {
        # RGB color image
        magick -size ${Width}x${Height} xc:$Color $Output
        Write-Host "✅ RGB image generated ($Color): $Output"
    }
    default {
        Write-Host "⚠️ Invalid type. Choose 1 (White), 2 (Transparent), or 3 (RGB)."
    }
}
