$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$modulePath = (Get-Item $here).Parent.FullName

$ModuleName = 'PSVersion'
$ManifestPath = "$ModulePath\$ModuleName.psd1"
if (Get-Module -Name $ModuleName) {
    Remove-Module $ModuleName -Force
}
Import-Module $ManifestPath -Verbose:$false

# test the module manifest - exports the right functions, processes the right formats, and is generally correct
Describe -Name 'Manifest' -Fixture {
    $ManifestHash = Invoke-Expression -Command (Get-Content $ManifestPath -Raw)

    It -name 'has a valid manifest' -test {
        {
            $null = Test-ModuleManifest -Path $ManifestPath -ErrorAction Stop -WarningAction SilentlyContinue
        } | Should Not Throw
    }


    It -name 'has a valid Description' -test {
        $ManifestHash.Description | Should Not BeNullOrEmpty
    }

    It -name 'has a valid guid' -test {
        $ManifestHash.Guid | Should Be 'ed7130ec-f8a2-4530-8382-38650275f0d8'
    }

    It -name 'has a valid version' -test {
        $ManifestHash.ModuleVersion -as [Version] | Should Not BeNullOrEmpty
    }

    It -name 'has a valid copyright' -test {
        $ManifestHash.CopyRight | Should Not BeNullOrEmpty
    }

    It -name 'has a valid license Uri' -test {
        $ManifestHash.PrivateData.Values.LicenseUri | Should Be 'https://github.com/janegilring/PSVersion/blob/master/LICENSE'
    }

    It -name 'has a valid project Uri' -test {
        $ManifestHash.PrivateData.Values.ProjectUri | Should Be 'https://github.com/janegilring/PSVersion'
    }

    It -name "gallery tags don't contain spaces" -test {
        foreach ($Tag in $ManifestHash.PrivateData.Values.tags) {
            $Tag -notmatch '\s' | Should Be $true
        }
    }
}

Describe 'General module control' -Tags 'FunctionalQuality' {

    It 'Imports without errors' {
        { Import-Module -Name $ManifestPath -Force -ErrorAction Stop } | Should -Not -Throw
        Get-Module $moduleName | Should -Not -BeNullOrEmpty
    }

}
