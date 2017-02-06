<#
#>
# current invokation path
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$module = "..\epAzureTools\epAzureTools.psm1"

# If module is loaded, unload it
Get-Module epAzureTools | Remove-Module -Force

Import-Module $module

Describe 'Get-epOutsideIPAddress Tests' {
    $OutsideIP = Get-epOutsideIPAddress

    Context "Returned object should contain values" {
         it 'should have an IP' {
            $OutsideIP.IPAddress | Should not be $null
         }

         it 'should have a PTR' {
             $OutsideIP.PTR | Should not be $null
         }
    }    
    Context 'Returned object.IPAddress should contain valid IP' {
        it 'should be four octets' {
            $OutsideIP.IPaddress | Should Match ([RegEx]::("^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$"))
        }
        it 'should be in valid range' {
            $match = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}`
                        (?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
            $OutsideIP.IPAddress | Should Match ([RegEx]::($match))
        }
        it 'should end with a digit' {
            $OutsideIP.IPAddress[-1] | Should Match ([RegEx]::("^[0-9]$"))
        }
    }
}


