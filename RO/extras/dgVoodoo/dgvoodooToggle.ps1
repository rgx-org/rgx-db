# dgVoodooToggle.ps1

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("on","off")]
    [string]$mode
)


if ($mode -eq "on") {
    Write-Host "`nTurning dgVoodoo on..."
} else {
    Write-Host "`nTurning dgVoodoo off..."
}

# Get the folder where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Get the RO folder from the script's folder
$parentDir = Split-Path -Parent $scriptDir
$parentDir = Split-Path -Parent $parentDir

# Files to copy/delete
$files = @(
    "D3D8.dll",
    "D3D9.dll",
    "dgVoodoo.conf",
    "D3DImm.dll",
    "DDraw.dll"
)

if ($mode -eq "on") {
    foreach ($file in $files) {
        $sourcePath = Join-Path $scriptDir $file
        $destPath   = Join-Path $parentDir $file
        if (Test-Path $sourcePath) {
            try {
                Copy-Item $sourcePath $destPath -Force
                Write-Host "Copied: $file"
            } catch {
                Write-Warning "Failed to copy: $file ($($_.Exception.Message))"
            }
        } else {
            Write-Warning "Not found in dgVoodoo folder: $file"
        }
    }
}
elseif ($mode -eq "off") {
    foreach ($file in $files) {
        $filePath = Join-Path $parentDir $file
        if (Test-Path $filePath) {
            try {
                Remove-Item $filePath -Force
                Write-Host "Deleted: $file"
            } catch {
                Write-Warning "Failed to delete: $file ($($_.Exception.Message))"
            }
        } else {
            Write-Host "Not found: $file"
        }
    }
}
