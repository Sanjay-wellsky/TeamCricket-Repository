
# Define an array of registry entries
$RegistryEntries = @( 
    @{ Path = 'HKLM:\SOFTWARE\FSLogix\Profiles\Apps'; Name = 'CleanupInvalidSessions'; Value = 1; Type = 'DWord' },
    @{ Path = 'HKLM:\SOFTWARE\FSLogix\Profiles'; Name = 'FlipFlopProfileDirectoryName'; Value = 1; Type = 'DWord' },
    @{ Path = 'HKLM:\SOFTWARE\FSLogix\Profiles'; Name = 'DeleteLocalProfileWhenVHDShouldApply'; Value = 1; Type = 'DWord' },
    @{ Path = 'HKLM:\SOFTWARE\FSLogix\Profiles'; Name = 'Enabled'; Value = 1; Type = 'DWord' },
    @{ Path = 'HKLM:\SOFTWARE\FSLogix\Profiles'; Name = 'PreventLoginWithTempProfile'; Value = 1; Type = 'DWord' },
    @{ Path = 'HKLM:\SOFTWARE\FSLogix\Profiles'; Name = 'ClearCacheOnLogoff'; Value = 1; Type = 'DWord' },
    @{ Path = 'HKLM:\SOFTWARE\FSLogix\Profiles'; Name = 'VolumeType'; Value = 'VHDX'; Type = 'String' }, # Corrected Type to "String"
    @{ Path = 'HKLM:\SOFTWARE\FSLogix\Profiles'; Name = 'PreventLoginWithFailure'; Value = 1; Type = 'DWord' }
)

# Iterate through the registry entries and apply them
foreach ($Entry in $RegistryEntries) {
    $Path = $Entry.Path
    $Name = $Entry.Name
    $Value = $Entry.Value
    $Type = $Entry.Type

    # Check if the registry path exists, and create it if it doesn't
    if (!(Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
        Write-Host "Created registry path: $Path"
    }

    # Create or update the registry value
    try {
        New-ItemProperty -LiteralPath $Path -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
        Write-Host "Registry entry updated: Path='$Path', Name='$Name', Value='$Value', Type='$Type'"
    } catch {
        Write-Host "Failed to update registry entry: Path='$Path', Name='$Name'. Error: $_" -ForegroundColor Red
    }
}

# Update a specific registry entry separately
$CachePath = 'HKLM:\SYSTEM\CurrentControlSet\Services\frxccds\Parameters'
if (!(Test-Path $CachePath)) {
    New-Item -Path $CachePath -Force | Out-Null
    Write-Host "Created registry path: $CachePath"
}

Set-ItemProperty -Path $CachePath -Name 'WriteCacheDirectory' -Value 'D:\ProgramData\FSLogix\Cache'
Write-Host "Specific registry entry updated: 'WriteCacheDirectory'"
