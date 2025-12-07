<#
.SYNOPSIS
    Master orchestrator for ImageMagick scripts (with automatic folder navigation).

.DESCRIPTION
    Loads helper scripts via dot-sourcing, runs them in sequence,
    and navigates into each output folder after processing.
    At the end, returns to the original working directory.
#>

Write-Host "🔧 Loading scripts..."

# Dot-source all scripts
. .\Magick-binarisation.ps1
. .\Magick-canvas.ps1
. .\Magick-create.ps1
. .\Magick-grey.ps1
. .\Magick-jpg2png.ps1
. .\Magick-level.ps1
. .\Magick-normalize.ps1
. .\Magick-renum.ps1
. .\Magick-split.ps1
. .\Magick-toPDF.ps1

Write-Host "✅ Scripts loaded."

# ==============================
# Hardcoded values (brute force)
# ==============================

# Global pattern
$Pattern      = "*.png"

# Output folders
$LevelFolder  = "Leveled"
$BinFolder    = "Binarized"
$GreyFolder   = "Grayscale"
$CanvasFolder = "Canvas"
$CreateFolder = "Created"
$Jpg2PngFolder= "ConvertedPNG"
$NormalizeFolder = "Normalized"
$RenumFolder  = "Renumbered"
$SplitFolder  = "Splitted"
$PdfFolder    = "PDF"

# Parameters for Level
$Black   = 10
$White   = 240
$Gamma   = 1.2

# Parameters for Binarisation
$Threshold = 70

# Parameters for Canvas (A4 @ 300 dpi)
$CanvasWidth  = 2480
$CanvasHeight = 3508
$CanvasDPI    = 300

# Parameters for Create (example: blank canvas)
$CreateWidth  = 800
$CreateHeight = 600
$CreateColor  = "white"

# Parameters for JPG2PNG
$JpgPattern   = "*.jpg"

# Parameters for Normalize
$NormalizeMode = "histogram"   # exemple: histogram, contrast, etc.

# Parameters for Renum
$StartNumber = 1
$Digits      = 3

# Parameters for Split
$SplitRows   = 2
$SplitCols   = 2







# ==============================
# Workflow example
# ==============================

# Save current directory
$InitialDir = Get-Location

Write-Host "▶ Step 1: Level adjustment"
Magick-Level -Pattern $Pattern -Black $Black -White $White -Gamma $Gamma -OutputFolder $LevelFolder
Set-Location $LevelFolder

Write-Host "▶ Step 2: Binarization"
Magick-Binarisation -Pattern $Pattern -Threshold $Threshold -OutputFolder $BinFolder
Set-Location $BinFolder

Write-Host "▶ Step 3: Grayscale conversion"
Magick-Grey -Pattern $Pattern -OutputFolder $GreyFolder
Set-Location $GreyFolder

Write-Host "▶ Step 4: Canvas resize to A4"
Magick-Canvas -Pattern $Pattern -Width $CanvasWidth -Height $CanvasHeight -DPI $CanvasDPI -OutputFolder $CanvasFolder
Set-Location $CanvasFolder

Write-Host "▶ Step 5: Create blank image"
Magick-Create -Width $CreateWidth -Height $CreateHeight -Color $CreateColor -OutputFolder $CreateFolder
Set-Location $CreateFolder

Write-Host "▶ Step 6: JPG to PNG conversion"
Magick-Jpg2Png -Pattern $JpgPattern -OutputFolder $Jpg2PngFolder
Set-Location $Jpg2PngFolder

Write-Host "▶ Step 7: Normalize"
Magick-Normalize -Pattern $Pattern -Mode $NormalizeMode -OutputFolder $NormalizeFolder
Set-Location $NormalizeFolder

Write-Host "▶ Step 8: Renumber files"
Magick-Renum -Pattern $Pattern -Start $StartNumber -Digits $Digits -OutputFolder $RenumFolder
Set-Location $RenumFolder

Write-Host "▶ Step 9: Split images"
Magick-Split -Pattern $Pattern -Rows $SplitRows -Cols $SplitCols -OutputFolder $SplitFolder
Set-Location $SplitFolder

Write-Host "▶ Step 10: Convert to PDF"
Magick-toPDF -Pattern $Pattern -OutputFolder $PdfFolder
Set-Location $PdfFolder

# Return to initial directory
Set-Location $InitialDir
Write-Host "↩️ Returned to initial directory: $InitialDir"

Write-Host "✅ Workflow completed."

# ==============================
# exit avoiding what follow
# ==============================
exit

# ==============================
# single action, select line and use F8 in ISE (start selection)
# ==============================

# ==============================
# Magick-Level
# ==============================
Magick-Level -Pattern $Pattern -Black $Black -White $White -Gamma $Gamma -OutputFolder $LevelFolder

Magick-Level -Pattern "*.png" -Black 10 -White 240 -Gamma 1.2 -OutputFolder "Leveled"

# ==============================
# Magick-Binarisation (agressive)
# ==============================
Magick-Binarisation -Pattern $Pattern -Threshold $Threshold -OutputFolder $BinFolder

Magick-Binarisation -Pattern "*.png" -Threshold 70 -OutputFolder "Binarized"

# ==============================
# Magick-Grey
# ==============================
Magick-Grey -Pattern $Pattern -OutputFolder $GreyFolder

Magick-Grey -Pattern "*.png" -OutputFolder "Grayscale"

# ==============================
# Magick-Canvas
# ==============================
Magick-Canvas -Pattern $Pattern -Width $CanvasWidth -Height $CanvasHeight -DPI $CanvasDPI -OutputFolder $CanvasFolder

Magick-Canvas -Pattern "*.png" -Width 2480 -Height 3508 -DPI 300 -OutputFolder "Canvas"

# ==============================
# Magick-Create
# ==============================
Magick-Create -Width $CreateWidth -Height $CreateHeight -Color $CreateColor -OutputFolder $CreateFolder

Magick-Create -Width 800 -Height 600 -Color "white" -OutputFolder "Created"

# ==============================
# Magick-Jpg2Png
# ==============================
Magick-Jpg2Png -Pattern $JpgPattern -OutputFolder $Jpg2PngFolder

Magick-Jpg2Png -Pattern "*.jpg" -OutputFolder "PNG"

# ==============================
# Magick-Normalize
# ==============================
Magick-Normalize -Pattern $Pattern -Mode $NormalizeMode -OutputFolder $NormalizeFolder

Magick-Normalize -Pattern "*.png" -Mode "histogram" -OutputFolder "Normalized"

# ==============================
# Magick-Renum
# ==============================
Magick-Renum -Pattern $Pattern -Start $StartNumber -Digits $Digits -OutputFolder $RenumFolder

Magick-Renum -Pattern "*.png" -Start 1 -Digits 3 -OutputBase "Le Son du Canon - No 01 page "

# ==============================
# Magick-Split
# ==============================
Magick-Split -Pattern $Pattern -Rows $SplitRows -Cols $SplitCols -OutputFolder $SplitFolder

Magick-Split -Pattern "*.png" -Rows 2 -Cols 2 -OutputFolder "Splitted"

# ==============================
# Magick-toPDF
# ==============================
Magick-toPDF -Pattern $Pattern -OutputFolder $PdfFolder

Magick-toPDF -Pattern "*.png"

