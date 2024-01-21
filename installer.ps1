function getRandom() {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
}

$wd = "cyberword1"
$path = "$env:temp/$wd"
$initial_dir = Get-Location
mkdir $path
cd $initial_dir
del installer.ps1
