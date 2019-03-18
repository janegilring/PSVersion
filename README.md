# PSVersion PowerShell module

This project has adopted [this code of conduct](CODE_OF_CONDUCT.md).

## Branches

### master
[![Build Status](https://dev.azure.com/janegilring/PSVersion/_apis/build/status/janegilring.PSVersion?branchName=master)](https://dev.azure.com/janegilring/PSVersion/_build/latest?definitionId=2&branchName=master)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/PSVersion.svg)](https://www.powershellgallery.com/packages/PSVersion)

This is the branch containing the latest release -
no contributions should be made directly to this branch.

### dev

[![Build Status](https://dev.azure.com/janegilring/PSVersion/_apis/build/status/janegilring.PSVersion?branchName=dev)](https://dev.azure.com/janegilring/PSVersion/_build/latest?definitionId=3?branchName=dev)

This is the development branch
to which contributions should be proposed by contributors as pull requests.
This development branch will periodically be merged to the master branch,
and be released to [PowerShell Gallery](https://www.powershellgallery.com/).

## Overview

Until PowerShell 5.0 was released as part of Windows Management Framework 5.0, the build number was rounded to .0, such as 1.0, 2.0, 3.0, and 4.0. However, in this new and fast moving pace Microsoft have gotten into, we will see more frequent updates to PowerShell than before. Due to this, the PowerShell version number isn’t simply 5.0 anymore as you might have expected. Now it’s a full build number, such as 5.0.10586.117 for the RTM release of Windows Management Framework 5 for downlevel operating systems.

Because of this difficulty, the PSVersion module was created. It contains the Get-PSVersion function, which can read a mapping table and convert the PSVersion property to a “PSFriendlyVersionName” which makes more sense to a user.

You can read more about the background and see examples in the following article on PowerShell Magazine:
http://www.powershellmagazine.com/2016/03/10/decoding-powershell-build-numbers

# Installation

The module is published to the PowerShell Gallery, which means you can install it using the following command from the PowerShellGet module:

`Install-Module -Name PSVersion`

or the following if you want it installed the current user' s profile rather than the system wide location:

`Install-Module -Name PSVersion -Scope CurrentUser`

When a new version is released with bug fixes or new functionality you can update to the latest version simply by typing the following command:

`Update-Module -Name PSVersion`

PowerShellGet is included by default in PowerShell V5, and available downlevel for PowerShell 3.0 and 4.0.

## Requirements

- Windows PowerShell 5.1, PowerShell Core 6.0 or later on the computer the module is installed on
- PowerShell Remoting must be enabled if targeting remote computers

## Usage

The module contains the following functions:

- **Get-PSVersion** - Returns information about the PowerShell version for the specified computer (defaults to localhost). By specifying the -ListVersion parameter all versions will be returned.
- **Update-PSVersionData** -  Updates mapping table used by Get-PSVersion, a function to map information from $PSVersionTable in order to retrieve friendly names for PowerShell build numbers

## Change log

- 2.1.0 Added support for PowerShell Core. Added custom formatting. Bugfix: Remote computers not processed when localhost is specified.
