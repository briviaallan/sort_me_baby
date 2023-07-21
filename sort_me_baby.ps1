# Function to extract commonalities from video titles
function Get-Commonality {
    param (
        [string]$FileName
    )

    # Extract commonalities from the file name using a regular expression
    # Customize this part based on your specific requirements and variations
    $Commonality = $FileName -match "season\s*\d+|s\s*\d+|ep\s*\d+|e\s*\d+"
    if ($Matches.Count -gt 0) {
        $Matches[0]
    } else {
        ""
    }
}

# Function to move the file to the appropriate subfolder
function Move-ToSubfolder {
    param (
        [string]$FileName,
        [string]$Category,
        [string]$Action,
        [string]$DestPath
    )

    # Get the commonality from the file name
    $Commonality = Get-Commonality $FileName

    # Choose the destination folder based on the category and commonality
    $DestFolder = Join-Path -Path $DestPath -ChildPath "$Category\$Commonality"

    # Create the destination folder if it doesn't exist
    if (-not (Test-Path $DestFolder -PathType Container)) {
        New-Item -ItemType Directory -Path $DestFolder -Force
    }

    # Move or copy the file to the subfolder based on user input
    if ($Action -eq "move") {
        # Check if the file already exists in the destination folder
        if (Test-Path -Path (Join-Path -Path $DestFolder -ChildPath (Split-Path -Leaf $FileName))) {
            # Check if the files are identical
            if ((Get-FileHash $FileName).Hash -eq (Get-FileHash (Join-Path -Path $DestFolder -ChildPath (Split-Path -Leaf $FileName))).Hash) {
                Write-Host "File '$(Split-Path -Leaf $FileName)' already exists and is identical. Skipping..."
                return
            } else {
                # Files are not identical, prompt to overwrite
                Write-Host "File '$(Split-Path -Leaf $FileName)' already exists in the destination folder."
                Write-Host "Do you want to overwrite the existing file? (Type 'yes' or 'no' and press Enter)"
                $overwrite = Read-Host
                if ($overwrite -ne "yes") {
                    Write-Host "File '$(Split-Path -Leaf $FileName)' was not moved."
                    return
                }
            }
        }
        Move-Item $FileName -Destination $DestFolder
    } elseif ($Action -eq "copy") {
        Copy-Item $FileName -Destination $DestFolder
    }
}

# Function to traverse subdirectories and sort files
function Sort-Files {
    param (
        [string]$Directory,
        [string]$Action,
        [string]$DestPath
    )

    $Files = Get-ChildItem $Directory -File
    $SubDirs = Get-ChildItem $Directory -Directory

    # Process files in the current directory
    foreach ($File in $Files) {
        Move-ToSubfolder $File.FullName $Action $DestPath
    }

    # Recursively process subdirectories
    foreach ($SubDir in $SubDirs) {
        Sort-Files $SubDir.FullName $Action $DestPath
    }
}

# Prompt the user to enter the source folder
Write-Host "Enter the source folder path and press Enter:"
$SourceDir = Read-Host

# Validate the source folder path
if (-not (Test-Path $SourceDir -PathType Container)) {
    Write-Host "Invalid source folder path. Please provide a valid path."
    exit 1
}

# Prompt the user to enter the destination folder
Write-Host "Enter the destination folder path and press Enter:"
$DestDir = Read-Host

# Validate the destination folder path and create it if it doesn't exist
if (-not (Test-Path $DestDir -PathType Container)) {
    New-Item -ItemType Directory -Path $DestDir -Force
}

# Ask the user whether to move or copy the files
Write-Host "Do you want to move or copy the files? (Type 'move' or 'copy' and press Enter)"
$Action = Read-Host

# Validate the user input for copy or move option
if ($Action -ne "move" -and $Action -ne "copy") {
    Write-Host "Invalid option. Please enter 'move' or 'copy'."
    exit 1
}

# Call the function to sort files in the source directory and its subdirectories
Write-Host "Sorting files..."
Sort-Files $SourceDir $Action $DestDir

# Optional: Print a message when the sorting is complete
Write-Host "Files sorted into appropriate folders."
