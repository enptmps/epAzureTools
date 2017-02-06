function Get-epVMInventory {
<#
#>
    [CmdletBinding()]
    Param(
        [Parameter()][String]$ResourceGroup
    )

    If ($ResourceGroup){
        $VMs = Get-AzureRMVM -ResourceGroupName $ResourceGroup
    } else {
        $VMs = Get-AzureRMVM
    }
    $OutputObject = @()

    ForEach ($VM in $VMs){
         $NetworkInterfaceID = ($VM.NetworkProfile.NetworkInterfaces).Id
         $NetworkInterface = Get-AzureRMNEtworkInterface | ?{$_.id -eq "$NetworkInterfaceID"}
         $PrimaryInternalIPAddress = $NetworkInterface.IpConfigurations[0].PrivateIpAddress
    

    $VMInventoryObject = New-Object -TypeName psobject
    $VMInventoryObject | Add-Member -Type NoteProperty -Name 'Name' -Value $VM.Name
    $VMInventoryObject | Add-Member -Type NoteProperty -Name 'IPAddress' -Value $PrimaryInternalIPAddress

    $OutputObject += $VMInventoryObject
    }
    
    Return $OutputObject
}