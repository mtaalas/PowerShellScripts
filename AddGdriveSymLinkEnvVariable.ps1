<#
    * Find what Virtual Disk Drive letter google drive is attached to.
    * Create/update User env. variable "Gdrive" to point at root of that.
    * Create/update a symbolic link "C:\Gdrive" that points to that location.
#>

$ErrorActionPreference = "Stop"

#Helper variables for customization:
    $SymLinkPath = "C:\Gdrive"
    $SymLinkName = 'Gdrive'
    $GdriveDescription = 'Google Drive'
    $EnvName = 'Gdrive'
    $EnvScope = 'User'

$driveLocation = Get-PSDrive | Where-Object { $_.Description -eq $GdriveDescription } | Select-Object -expandProperty Root

if (-Not $driveLocation)
{
    echo "Drive with description '$GdriveDescription' not found."
    Echo "Check the drive name and edit the script accordingly"
    exit 
}    

if ($Env:Gdrive){
    echo "Add Enviroment Variable "$EnvName" to scope "$EnvScope" ..."
    [Environment]::SetEnvironmentVariable($EnvName, $driveLocation, $EnvScope)
}

echo "Check if $SymLinkPath already exists..."
if (Test-Path $SymLinkPath){
    echo "$SymLinkPath already exists, deleting..."
    (Get-Item $SymLinkPath).Delete()
}

echo "Create new symlink $SymLinkPath with target "@Env:Gdrive""
New-Item -Item
