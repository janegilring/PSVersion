Import-Module $PSScriptRoot\..\PSVersion.psd1 -Force

InModuleScope PSVersion {

Describe 'Get-PSVersion' {

 Context "Desired output" {

    It "Returns a PSCustomObject" {
        (Get-PSVersion).GetType().FullName | Should Be 'System.Management.Automation.PSCustomObject'
    }

    }

    Context "Test help examples" {

    It "Tests example 1: Get-PSVersion" {
    (Get-PSVersion).PSVersion | Should Be $PSVersionTable.PSVersion.ToString()
    }

    }
  }

}