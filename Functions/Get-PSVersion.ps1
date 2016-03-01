function Get-PSVersion 
{

<#
.SYNOPSIS
    Maps information from $PSVersionTable to a mapping table to retrieve friendly names for Windows PowerShell build numbers
 
.DESCRIPTION
    Get-PSVersion is a function to map information from $PSVersionTable to a mapping table in order to retrieve friendly names for Windows PowerShell build numbers.
    For example, if the build number is 5.0.10586.117, the returned friendly name will be 'Windows PowerShell 5 RTM 1512'.
    For remote computers, the function relies on PowerShell remoting.
 
.PARAMETER ComputerName
    The remote computer(s) to retrieve PowerShell version information from.

.PARAMETER Credential
    Specifies a user account that has permission to perform this action. The default
    is the current user.
 
.EXAMPLE
     Get-PSVersion -ComputerName 'ComputerA','ComputerB'

.EXAMPLE
     'ComputerA','ComputerB | Get-PSVersion

.EXAMPLE
     Get-PSVersion -ComputerName 'ComputerA','ComputerB -Credential (Get-Credential)

.EXAMPLE
     Get-ADComputer -Filter 'operatingsystem -like "*Server*"' | Select-Object -ExpandProperty Name | Sort-Object -Property Name | Get-PSVersion
 
.INPUTS
    String
 
.OUTPUTS
    Selected.System.Collections.Hashtable
 
.NOTES
    Author:  Jan Egil Ring
    Twitter: @JanEgilRing
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string[]]$ComputerName=$env:computername,

        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty
    )

    BEGIN {        
        $Params = @{}
 
        If ($PSBoundParameters['Credential']) {
            $Params.Credential = $Credential
        }

            $functionpath = Split-Path -Path ${function:Get-PSVersion}.File
            $modulepath = Split-Path -Path $functionpath
            $mappingtablepath = Join-Path -Path $modulepath -ChildPath 'PSVersionMappingTable.json'
            $mappingtable = Get-Content -Path $mappingtablepath | ConvertFrom-Json

            $ComputerNames = @()

        }

    PROCESS {

        $ComputerNames += $ComputerName
   
   }
   END {

   $Params.ComputerName = $ComputerNames
   
        
        Invoke-Command @Params {

             $PSVersionTable

            } -ErrorAction SilentlyContinue -ErrorVariable failed | Select-Object @{Name='PSComputerName';e={$_.PSComputerName}},@{Name='PSVersion';e={$_.PSVersion.ToString()}},@{Name='PSVersionFriendlyName';e={

                  $FriendlyName = $mappingtable.$($_.PSVersion.ToString()).FriendlyName

                  if ($FriendlyName) {

                  $FriendlyName

                  } else {

                  "Unknown $($_.PSVersion)"

                  }

                }
             }
        
       if ($failed) {

            foreach ($item in $failed)
            {

                [pscustomobject]@{
                PSComputerName = $item.TargetObject
                PSVersion = 'N/A - PS Remoting failed'
                PSVersionFriendlyName = 'N/A - PS Remoting failed'

            }
            }


        }

   }
    
}