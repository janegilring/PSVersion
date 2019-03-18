function Get-PSVersion
{

    <#
.SYNOPSIS
    Maps information from $PSVersionTable to a mapping table to retrieve friendly names for Windows PowerShell build numbers

.DESCRIPTION
    Get-PSVersion is a function to map information from $PSVersionTable to a mapping table in order to retrieve friendly names for Windows PowerShell build numbers.
    For example, if the build number is 5.0.10586.117, the returned friendly name will be 'Windows PowerShell 5 RTM 1512'.
    For remote computers, the function relies on PowerShell remoting.
    By default a mapping table bundled with the module is used a data source. The switch parameter -UpdatePSVersionData can be used to download the latest version.

A useful tip is to use a scheduled job to automatically update both the PSVersion module and the PSVersionData:
$ScheduledJobOption = New-ScheduledJobOption -RunElevated
$Trigger = New-JobTrigger -At 03:00:00 -Daily

Register-ScheduledJob -Name Update-PSVersion -ScriptBlock {

Update-Module -Name PSVersion -Force
Import-Module -Name PSVersion
Update-PSVersionData

} -Trigger $Trigger -ScheduledJobOption $ScheduledJobOption -RunNow



.PARAMETER ComputerName
    The remote computer(s) to retrieve PowerShell version information from.

.PARAMETER Credential
    Specifies a user account that has permission to perform this action. The default
    is the current user.

.PARAMETER UpdatePSVersionData
    Triggers the Update-PSVersionData function which will update the PowerShell version mapping table

.EXAMPLE
     Get-PSVersion

.EXAMPLE
     Get-PSVersion -UpdatePSVersionData

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
    System.Management.Automation.PSCustomObject

.NOTES
    Author:  Jan Egil Ring
    Twitter: @JanEgilRing
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [string[]]$ComputerName = $env:computername,
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
        [switch]$UpdatePSVersionData,
        [parameter(ParameterSetName = "ListVersion")]
        [switch]$ListVersion
    )

    BEGIN
    {
        $Params = @{}


        If ($PSBoundParameters['Credential'])
        {
            $Params.Credential = $Credential
        }

        If ($PSBoundParameters['UpdatePSVersionData'])
        {
            Update-PSVersionData -ErrorAction SilentlyContinue
        }

        $functionpath = Split-Path -Path ${function:Get-PSVersion}.File
        $modulepath = Split-Path -Path $functionpath
        $mappingtablemodulepath = Join-Path -Path $modulepath -ChildPath 'PSVersionMappingTable.json'


        if ($IsLinux)
        {
            $mappingtableappdatapath = Join-Path -Path "$($home)/.config" -ChildPath 'PSVersionMappingTable.json'
        }
        else
        {
            $mappingtableappdatapath = Join-Path -Path $env:LOCALAPPDATA\Microsoft\Windows\PowerShell -ChildPath 'PSVersionMappingTable.json'
        }

        if (Test-Path -Path $mappingtableappdatapath)
        {

            Write-Verbose -Message "Found $mappingtableappdatapath, using this version..."
            $mappingtablepath = $mappingtableappdatapath

        }
        else
        {

            Write-Verbose -Message "$mappingtableappdatapath not found, using the mapping table which is bundled with the module..."
            $mappingtablepath = $mappingtablemodulepath

        }

        $mappingtable = Get-Content -Path $mappingtablepath -Raw | ConvertFrom-Json

        If ($PSBoundParameters['ListVersion'])
        {

            Write-Verbose -Message "Parameter Set: ListVersion"
            Write-Verbose -Message "mappingtablepath: $mappingtablepath"

            $mappingtable | Add-ObjectDetail -TypeName 'PSVersionInfoList'

            break

        }


        $ComputerNames = @()

    }

    PROCESS
    {

        $ComputerNames += $ComputerName

    }
    END
    {

        If (-not ($PSBoundParameters['ComputerName']) -or $ComputerName -eq $env:computername -or $ComputerName -eq '127.0.0.1' -or $ComputerName -eq 'localhost' -or $ComputerName -eq '.')
        {

            Write-Verbose -Message 'Parameter -ComputerName not specified, skipping PS Remoting and retrieving information from localhost directly from $PSVersionTable'

            $PSVersion = $PSVersionTable.PSVersion.ToString()
            $FriendlyName = ($mappingtable | Where-Object {$_.Name -eq $PSVersion}).FriendlyName


            if (-not ($FriendlyName))
            {

                Write-Verbose -Message 'FriendlyName not found in mappingtable, trying to update the local mapping table using Update-PSVersionData...'

                Update-PSVersionData -ErrorAction SilentlyContinue

                $mappingtable = Get-Content -Path $mappingtablepath -Raw | ConvertFrom-Json
                $FriendlyName = ($mappingtable | Where-Object {$_.Name -eq $PSVersion}).FriendlyName

                if (-not ($FriendlyName))
                {

                    Write-Verbose -Message 'FriendlyName still not found in mappingtable, setting value to Unknown'

                    $FriendlyName = "Unknown $($_.PSVersion)"

                }
                else
                {

                    Write-Verbose -Message 'FriendlyName found after calling Update-PSVersionData'

                }
            }


            $output = [pscustomobject]@{
                PSComputerName        = hostname
                PSVersion             = $PSVersionTable.PSVersion.ToString()
                PSVersionFriendlyName = $FriendlyName
            }

            $output | Foreach-Object {Add-ObjectDetail -InputObject $_ -TypeName 'PSVersionInfo'}

        }

        $LocalHost = @($env:computername,'127.0.0.1','localhost','.')
        $ComputerNames = $ComputerNames | Where-Object {$PSItem -notin  $LocalHost}

        if ($ComputerNames) {

        $Params.ComputerName = $ComputerNames

        Invoke-Command @Params {

            $PSVersionTable

        } -ErrorAction SilentlyContinue -ErrorVariable failed | Select-Object @{Name = 'PSComputerName'; e = {$_.PSComputerName}}, @{Name = 'PSVersion'; e = {$_.PSVersion.ToString()}}, @{Name = 'PSVersionFriendlyName'; e = {

                $PSVersion = $_.PSVersion.ToString()
                $FriendlyName = ($mappingtable | Where-Object {$_.Name -eq $PSVersion}).FriendlyName

                if ($FriendlyName)
                {

                    $FriendlyName

                }
                else
                {

                    "Unknown $($_.PSVersion)"

                }

            }
        } | Add-ObjectDetail -TypeName 'PSVersionInfo'

    }


        if ($failed)
        {

            foreach ($item in $failed)
            {

                [pscustomobject]@{
                    PSComputerName        = $item.TargetObject
                    PSVersion             = $null
                    PSVersionFriendlyName = 'N/A - PS Remoting failed'
                } | Add-ObjectDetail -TypeName 'PSVersionInfo'
            }


        }

    }

}
