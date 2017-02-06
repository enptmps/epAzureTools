# REQUIREMENTS

## epAzureTools Module Requirements

* Module will contain working PowerShell code
* Module will contain a properly formatted .psm1 file
* Module will contain a properly formatted .psd1 file

## Functions

* Functions will be divided into public and private based on end user exposure
* Functions will contain working PowerShell code
* Functions will contain a help block starting with <# and ending with #>
* Functions help block will contain a .SYNOPSYS area
* Functions help block will contain a .DESCRIPTION area
* Functions help block will contain a .EXAMPLES area
* Functions will be advanced functions and contain the keywords 'function', 'cmdletbinding' and 'param'
* Functions will contain Verbose capabilities in the form of 'Write-Verbose' blocks
* Functions will properly respond to the -WhatIf switch
* Functions will not utilize legacy input from 'Read-Host'
* Functions will not utilize legacy output via 'Write-Host'

### Enable-epAzureRemoteAccess
* Get current outside IP address of location where command was executed
* Amend/Create NSG to VM specified
* Allow 3389 inbound from OutsideIP by default
* Allow 22 inbound from OutsideIP if -Linux switch is triggered
* Not break any existing NSG/NSG Rules in place

### Disable-epAzureRemoteAccess
* Remove Access as granted by Enable-epAzureRemoteAccess

### Connect-epAzureFileShare
* [INPUT] Storage Account, Share Name and Drive Letter
* Check the Storage Account and hold it/return an error & break
* Gather Storage Account Key
* Create A Storage Context
* Check the Share and hole it/return an error & break
* [OUTPUT] Map azure share to specified drive letter via net use

### Get-epOutsideIPAddress
* [INPUT] None
* Gather current outside IP address via call to icanhazip.com
* Gather current PTR via call to icanhazptr.com
* [OUTPUT] Custom PSObject containing IPAddress and PTR

### New-epAzureVirtualMachineConfiguration
* [INPUT]
* Create configuration object for new VM
* handle differences between systems with/without data disks
* handle differences between systems from marketplace/custom image
* handle instances where vnet and sub exist or do not exist
* handle default NSG mapping
* [OUTPUT] CustomObjectfromClass? (PS5 requirement)

### New-epAzureVirtualMachine
* [INPUT] CustomObjectfromClass?

### Update-epAzureLocalGateway
* [INPUT]
* Store Connection Info
* Remove Connection
* Update PSK/LocalPrefix/LocalEndpoint details
* Recreate Connection

### New-epAzureVPN