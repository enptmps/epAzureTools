function Connect-epAzureFileShare {
<#
.SYNOPSIS
Connect-epAzureFileShare quickly maps an Azure file share to a drive letter of your choice
.DESCRIPTION
Long description
.EXAMPLE
Connect-epAzureFileShare -StorageAccountName "someaccount01" -ShareName "myfileshare" -DriveLetter "M"
.EXAMPLE
Connect-epAzureFileShare
.OUTPUTS
Returns a properly formatted 'net use' command
.COMPONENT
epAzureTools module (future)
.FUNCTIONALITY
Searchs for the given storage account, grabs the Key and trys to mount the share
#>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [String]$StorageAccountName,
        
        [Parameter(Mandatory=$true)]
        [String]$ShareName,
        
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,2)]
        [String]$DriveLetter
    )

    $StorageAccount = Get-AzureRMStorageAccount | Where-Object {$_.StorageAccountName -eq "$StorageAccountName"}
    
    # Validate DriveLetter and correct if needed
    If ($DriveLetter.Length -gt 1)
    {
        Write-Verbose "DriveLetter.Length was Greater than 1"
        If (!($DriveLetter.EndsWith(':')))
        {
            Write-Verbose "DriveLetter[1] was not ':'"
            $DriveLetter[1] = ":"
        }
    } else {

        $DriveLetter = $DriveLetter +":"
    }

    # Check DriveLetter is not currently in use 
    $DriveExists = (Get-PSDrive -Name $DriveLetter[0] -ErrorAction SilentlyContinue)
    if ($DriveExists)
    {
        Write-Output "DriveLetter $($DriveLetter[0]) is in use, please select another"
        break
    }
    $StorageAccountKey = (Get-AzureRmStorageAccountKey $StorageAccount.StorageAccountName -ResourceGroupName $StorageAccount.ResourceGroupName)[0].Value
    $StorageContext = (New-AzureStorageContext -StorageAccountName $StorageAccount.StorageAccountName -StorageAccountKey $StorageAccountKey)
    $UNCPath = "\\" +($StorageAccount.PrimaryEndpoints.File).SubString(8).TrimEnd('/')
    $Share = (Get-AzureStorageShare -Context $StorageContext)
    $CombinedPath = (Join-Path $UNCPath -ChildPath $ShareName)
    $UserName = "/u:" +$StorageAccount.StorageAccountName
    Write-Verbose "Executing: net use $DriveLetter $CombinedPath $UserName $StorageAccountKey"
    
    Return net use $DriveLetter $CombinedPath $UserName $StorageAccountKey
}