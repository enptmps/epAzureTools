. $PSScriptRoot\Public\function-Enable-epAzureRemoteAccess.ps1
. $PSScriptRoot\Public\function-Disable-epAzureRemoteAccess.ps1
. $PSScriptRoot\Private\function-Get-OutsideIPAddress.ps1
. $PSScriptRoot\Private\function-Add-epAzureSimpleNSGRule.ps1
. $PSScriptRoot\Private\funciton-Remove-epAzureSimpleNSGRule.ps1

Export-ModuleMember Enable-epAzureRemoteAccess.ps1
Export-ModuleMember Disable-epAzureRemoteAccess.ps1