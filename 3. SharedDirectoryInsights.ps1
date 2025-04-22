# Define the output file
$OutputFile = "C:\Insights\SharedDirectoriesDetails.csv" # Replace with your desired output file path

# Get shared directories from the current machine
$Shares = Get-WmiObject -Class Win32_Share

# Create a collection to store share data
$ShareData = @()
foreach ($Share in $Shares) {
    # Determine the meaning of ShareType
    $ShareTypeMeaning = switch ($Share.Type) {
        0           { "Disk Drive Share" }
        1           { "Print Queue Share" }
        2           { "Device Share" }
        3           { "IPC (Inter-Process Communication) Share" }
        2147483648  { "Administrative Share" }
        2147483651  { "Administrative IPC Share" }
        Default     { "Unknown Share Type" }
    }

    # Add the share details and meaning to the collection
    $ShareData += [PSCustomObject]@{
        Name              = $Share.Name
        Path              = $Share.Path
        Description       = $Share.Description
        ShareType         = $Share.Type
        ShareTypeMeaning  = $ShareTypeMeaning
        MaximumAllowed    = $Share.MaximumAllowed
    }
}

# Export the share data to a CSV file
$ShareData | Export-Csv -Path $OutputFile -NoTypeInformation

Write-Host "Detailed file share information saved to $OutputFile"