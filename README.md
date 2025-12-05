# Magick-PowerShell Toolkit

___
## Overview
This project provides a set of **PowerShell scripts (.ps1)** to automate image processing tasks using **ImageMagick**.  
The goal is to simplify batch operations such as resizing, DPI normalization, canvas adjustment, renaming, and PDF generation.

**Why?**  
Working with large sets of images can be time-consuming when adjustments are done manually.  
These scripts allow you to standardize dimensions, resolution, and naming conventions, making it easier to prepare images for printing, archiving, or PDF export.

This is particularly the case for the project to preserve the heritage of magazines through the [Abandonware Magazines](https://www.abandonware-magazines.org/) initiative.

___
## Installation & Usage

### 1. Install ImageMagick
- Download and install **ImageMagick** from the official website.  [ImageMagick Download Page](https://imagemagick.org/script/download.php) (right clic to open in new folder).
- Extract or install it in any location you prefer.  
- Make sure the `magick` command is available in your system PATH.

### 2. Place the scripts
- Copy the `.ps1` scripts from this repository into your PowerShell ISE scripts folder:  

```
%USERPROFILE%\Documents\WindowsPowerShell\Scripts
```

- Open System Properties → Environment Variables.
- Edit the PATH variable and add: "%USERPROFILE%\Documents\WindowsPowerShell\Scripts"
- Save


### 3. Run the scripts
- Open **PowerShell ISE** (or the standard PowerShell console).  
- Review and adjust parameters if necessary (depending on whether you are using ISE or console).  
- Navigate to the folder containing your images.  
- Run the desired script:  

To execute the script, click the Play button in ISE or run it from the PowerShell console.

### 4. Get-Help

All PowerShell scripts in this project include **Comment-Based Help** (`<# … #>`).  
You can use the built-in `Get-Help` command to display the documentation directly in the console.

#### Example

```powershell
Get-Help .\YourScript.ps1 -Full
```
___
## Work in progress.

To DO : 

New Magick script.

___
