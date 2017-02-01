# REQUIREMENTS

## epAzureTools Module Requirements

* Module will contain working PowerShell code
* Module will contain a properly formatted .psm1 file
* Module will contain a properly formatted .psd1 file

## Functions

* Functions will be devided into public and private based on end user exposure
* Functions will contain working PowerShell code
* Functions will contain a help block starting with <# and ending with #>
* Functions help block will contain a .SYNOPSYS area
* Functions help block will contain a .DESCRIPTION area
* Functions help block will contain a .EXAMPLES area
* Functions will be advanced functions and contain the keywords 'function', 'cmdletbinding' and 'param'
* Functions will contain Verbose capabilities in the form of 'Write-Verbose' blocks
* Functions will not utilize legacy input from 'Read-Host'
* Functions will not utilize legacy output via 'Write-Host'

### Enable-epAzureRemoteAccess

### Disable-epAzureRemoteAccess