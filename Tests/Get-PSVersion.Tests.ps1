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

    Context "Omits PS Remoting for localhost" {

    Disable-PSRemoting -Force -WarningAction SilentlyContinue

    It "Omits PS Remoting for localhost" {
    (Get-PSVersion -ComputerName localhost).PSVersion | Should Be $PSVersionTable.PSVersion.ToString()
    }
    It 'Omits PS Remoting for $env:computername' {
    (Get-PSVersion -ComputerName $env:computername).PSVersion | Should Be $PSVersionTable.PSVersion.ToString()
    }
    It "Omits PS Remoting for ." {
    (Get-PSVersion -ComputerName .).PSVersion | Should Be $PSVersionTable.PSVersion.ToString()
    }
    It "Omits PS Remoting for localhost" {
    (Get-PSVersion -ComputerName 127.0.0.1).PSVersion | Should Be $PSVersionTable.PSVersion.ToString()
    }
        Enable-PSRemoting -Force
    }

  }

}