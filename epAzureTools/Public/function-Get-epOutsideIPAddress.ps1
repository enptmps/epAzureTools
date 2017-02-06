function Get-epOutsideIPAddress {
<#
.SYNOPSIS
   Function to return your external IP address
.DESCRIPTION
   Get-epOutsideIPAddress hits a web service and returns your outside interface IP address via a single command
.EXAMPLE
   Get-epOutsideIPAddress
#>
    [CmdletBinding()]
    Param()

    Process
    {
        Write-Verbose "Gathering IP from WebService..."
        $holdIP = Invoke-WebRequest -Uri http://icanhazip.com
        Write-Verbose "Gathering PTR from WebService"
        $holdPTR = Invoke-WebRequest -Uri http://icanhazptr.com

        [String]$IPAddress = $($holdIP.Content).TrimEnd()
        Write-Verbose "IP returned as $IPAddress"
        [String]$PTR = $($holdPTR.Content).TrimEnd()
        Write-Verbose "PTR returned as $PTR"

        Write-Verbose "Creating Output Object"
        $OutsideIP = New-Object -TypeName PSObject
        $OutsideIP | Add-Member -Type NoteProperty -Name IPAddress -Value $IPAddress
        $OutsideIP | Add-Member -Type NoteProperty -Name PTR -Value $PTR
    } # process block

    End
    {
        Return $OutsideIP
    } # end block

} # function