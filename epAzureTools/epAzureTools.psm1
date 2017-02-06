#. $PSScriptRoot\Public\function-Enable-epAzureRemoteAccess.ps1
#. $PSScriptRoot\Public\function-Disable-epAzureRemoteAccess.ps1
. $PSScriptRoot\Private\function-Get-epOutsideIPAddress.ps1
. $PSScriptRoot\Public\function-Connect-epAzureFileShare.ps1
#. $PSScriptRoot\Private\function-Add-epAzureSimpleNSGRule.ps1
#. $PSScriptRoot\Private\funciton-Remove-epAzureSimpleNSGRule.ps1

#Export-ModuleMember Enable-epAzureRemoteAccess
#Export-ModuleMember Disable-epAzureRemoteAccess
Export-ModuleMember -Function *-*
#Export-ModuleMember 