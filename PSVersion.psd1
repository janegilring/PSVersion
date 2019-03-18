﻿#
# Module manifest for module 'PSVersion'
#
# Generated by: Jan Egil Ring
#
# Generated on: 29.02.2016
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSVersion.psm1'

# Version number of this module.
ModuleVersion = '2.0'

# ID used to uniquely identify this module
GUID = 'ed7130ec-f8a2-4530-8382-38650275f0d8'

# Author of this module
Author = 'Jan Egil Ring'

# Company or vendor of this module
CompanyName = 'PS Community'

# Copyright statement for this module
Copyright = '(c) 2019 Jan Egil Ring. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Contains a function (Get-PSVersion) and a mapping-table to get a friendly name for the PowerShell version number. For example, "Windows PowerShell 5 RTM 1602" instead of "5.0.10586.117".'

CompatiblePSEditions = 'Core','Desktop'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = 'Get-PSVersion','Update-PSVersionData'

# Cmdlets to export from this module
CmdletsToExport = ''

# Variables to export from this module
VariablesToExport = ''

# Aliases to export from this module
AliasesToExport = ''

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        LicenseUri = 'https://raw.githubusercontent.com/janegilring/PSVersion/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/janegilring/PSVersion'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '
        1.8 - Added new build numbers added since April 2017.
        1.7 - Added logic to update local version mapping table when FriendlyName is unknown.
        1.6.1 - Added build 5.1.14393.479 (Windows 10 1607 + KB3201845 1612) to version mapping table.
        '

        # External dependent modules of this module
        # ExternalModuleDependencies = ''

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}


