function _MapAzureStorageContext {
<#
#>
    [CmdletBinding()]
    Param(
        [Parameter()][String]$StorageAccountName,
        [Parameter()][String]$ResourceGroupName
    )
$StorageAccountKey = (Get-AzureRmStorageAccountKey $StorageAccountName -ResourceGroupName $ResourceGroupName)[0].Value
$StorageContext = (New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey)

Return $StorageContext

}