# Prompt user for inputs
$SourcePath = Read-Host "Enter the source folder path"
$LastAccessDuration = Read-Host "Enter the last access duration in days"
$MoveOrDelete = Read-Host "Choose an option
1. Move
2. Delete"

# If operation is "Move," prompt for target path
if ($MoveOrDelete -eq "1") {
    $TargetPath = Read-Host "Enter the target folder path for moved files"
}

# Validate inputs
if (-Not (Test-Path $SourcePath)) {
    Write-Host "The source folder does not exist. Please check the path." -ForegroundColor Red
    exit
}

if ($MoveOrDelete -ne "1" -and $MoveOrDelete -ne "2") {
    Write-Host "Invalid operation specified. Use 1 to move the filesto specific folder or 2 to delete the files." -ForegroundColor Red
    exit
}

if ($MoveOrDelete -eq "1" -and (-Not $TargetPath)) {
    Write-Host "Target path is required for Move operation. Please provide a valid path." -ForegroundColor Red
    exit
}

# Create target folder if it doesn't exist (for Move operation)
if ($MoveOrDelete -eq "1" -and (-Not (Test-Path $TargetPath))) {
    Write-Host "The target folder does not exist. Creating it..." -ForegroundColor Yellow
    New-Item -Path $TargetPath -ItemType Directory
}

# Calculate threshold date based on last access duration
$ThresholdDate = (Get-Date).AddDays(-[int]$LastAccessDuration)

# Perform operation (Move/Delete)
Get-ChildItem -Path $SourcePath -File | ForEach-Object {
    if ($_.LastAccessTime -lt $ThresholdDate) {
        if ($MoveOrDelete -eq "1") {
            Move-Item -Path $_.FullName -Destination $TargetPath
            Write-Host "Moved: $($_.FullName)" -ForegroundColor Green
        } elseif ($MoveOrDelete -eq "2") {
            Remove-Item -Path $_.FullName -Force
            Write-Host "Deleted: $($_.FullName)" -ForegroundColor Orange
        }
    }
}