# Magick-PowerShell Toolkit

___
## Overview
This project provides a set of **PowerShell scripts (.ps1)** to automate image processing tasks using **ImageMagick**.  
The goal is to simplify batch operations such as resizing, DPI normalization, canvas adjustment, renaming, and PDF generation.

**Why?**  
Working with large sets of images can be time-consuming when adjustments are done manually.  
These scripts allow you to standardize dimensions, resolution, and naming conventions, making it easier to prepare images for printing, archiving, or PDF export.

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

Clic the **play** button in ISE.\
or\
Console:
```powershell
.\Magick-[].ps1 -parameters
```

___
## Work in progress.

To DO : 

Default parameters and console parameters.
___
