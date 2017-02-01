$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$module = 'epAzureTools'

$moduleroot = "$here\..\$module"
$pvtFunction = "$moduleroot\Private"
$pubFunction = "$moduleroot\Public"

Describe -Tags ('Unit', 'Acceptance') "$module Module Tests"  {

  Context 'Module Setup' {
    It "has the root module $module.psm1" {
      "$moduleroot\$module.psm1" | Should Exist
    }

    It "has the a manifest file of $module.psm1" {
      "$moduleroot\$module.psd1" | Should Exist
      "$moduleroot\$module.psd1" | Should Contain "$module.psm1"
    }
    
    It '$module folder has public functions' {
      "$pubFunction\function-*.ps1" | Should Exist
    }

    It '$module folder has private functions' {
      "$pvtFunction\function-*.ps1" | Should Exist
    }

    It "$module is valid PowerShell code" {
      $psFile = Get-Content -Path "$moduleroot\$module.psm1" `
                            -ErrorAction Stop
      $errors = $null
      $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
      $errors.Count | Should Be 0
    }

  } # Context 'Module Setup'


  $functions = ((Get-ChildItem C:\Data\Code\Repos\enptmps\epAzureTools\epAzureTools\ -Recurse) | Where-Object {$_.name -like "function-*"})
  $functionPaths = ($functions).PSPath
  $functionNames = $functions | % basename
  #$functions = ('Get-NoAgenda',
  #              'Get-PodcastData',
  #              'Get-PodcastMedia',
  #              'Get-PodcastImage',
  #              'ConvertTo-PodcastHtml',
  #              'ConvertTo-PodcastXML',
  #              'Write-PodcastHtml', 
  #              'Write-PodcastXML'
  #             )

  foreach ($function in $functions)
  {
      $function | Split-Path
    Context "Test Function $function" {
      
      It "$function.ps1 should exist" {
        "$here\function-$function.ps1" | Should Exist
      }
    
      It "$function.ps1 should have help block" {
        "$here\function-$function.ps1" | Should Contain '<#'
        "$here\function-$function.ps1" | Should Contain '#>'
      }

      It "$function.ps1 should have a SYNOPSIS section in the help block" {
        "$here\function-$function.ps1" | Should Contain '.SYNOPSIS'
      }
    
      It "$function.ps1 should have a DESCRIPTION section in the help block" {
        "$here\function-$function.ps1" | Should Contain '.DESCRIPTION'
      }

      It "$function.ps1 should have a EXAMPLE section in the help block" {
        "$here\function-$function.ps1" | Should Contain '.EXAMPLE'
      }
    
      It "$function.ps1 should be an advanced function" {
        "$here\function-$function.ps1" | Should Contain 'function'
        "$here\function-$function.ps1" | Should Contain 'cmdletbinding'
        "$here\function-$function.ps1" | Should Contain 'param'
      }
      
      It "$function.ps1 should contain Write-Verbose blocks" {
        "$here\function-$function.ps1" | Should Contain 'Write-Verbose'
      }
    
      It "$function.ps1 should not contain Write-Host blocks" {
        "$here\function-$function.ps1" | Should not Contain 'Write-Host'
      }
    
      It "$function.ps1 is valid PowerShell code" {
        $psFile = Get-Content -Path "$here\function-$function.ps1" `
                              -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
        $errors.Count | Should Be 0
      }

    
    } # Context "Test Function $function"

    Context "$function has tests" {
      It "function-$($function).Tests.ps1 should exist" {
        "function-$($function).Tests.ps1" | Should Exist
      }
    }
  
  } # foreach ($function in $functions)


}