function Update-PSVersionData
{

<#
.SYNOPSIS
    Updates mapping table used by Get-PSVersion
 
.DESCRIPTION
    Updates mapping table used by Get-PSVersion, a function to map information from $PSVersionTable in order to retrieve friendly names for Windows PowerShell build numbers
 
.PARAMETER Uri
    The Uri to download PowerShell version information from.
 
.EXAMPLE
     Update-PSVersionData

.EXAMPLE
     Update-PSVersionData -Verbose

.EXAMPLE
     Update-PSVersionData -Uri 'https://www.domain.com/PSVersionMappingTable.json'
 
.INPUTS
    String
 
.OUTPUTS
    None
 
.NOTES
    Author:  Jan Egil Ring
    Twitter: @JanEgilRing
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string]$Uri = 'https://raw.githubusercontent.com/janegilring/PSVersion/master/PSVersionMappingTable.json'
    )

    
            $DestinationFile = Join-Path -Path $env:LOCALAPPDATA\Microsoft\Windows\PowerShell -ChildPath 'PSVersionMappingTable.json'
            
            try {

            Write-Verbose -Message "Trying to download $Uri using Invoke-WebRequest..."

            Invoke-WebRequest -Uri $Uri -OutFile $DestinationFile -ErrorAction Stop

            Write-Verbose -Message "$Uri successfully downloaded to $DestinationFile"

            Write-Verbose -Message "PSVersionData was updated successfully"

            }

            catch {

            throw "An error occured while trying to download $Uri to $DestinationFile, exception: $($_.Exception)"

            }
    
}