

| Branch | AzurePipelines CI | AppVeyor CI |
| --- | --- | --- |
| master | [![Build Status](https://dev.azure.com/janegilring/PSVersion/_apis/build/status/janegilring.PSVersion)](https://dev.azure.com/janegilring/PSVersion/_build/latest?definitionId=2) | [![Build status](https://ci.appveyor.com/api/projects/status/swph5y5fp6ruvy2b?svg=true)](https://ci.appveyor.com/project/janegilring/psversion)

# PSVersion

Until PowerShell 5.0 was released as part of Windows Management Framework 5.0, the build number was rounded to .0, such as 1.0, 2.0, 3.0, and 4.0. However, in this new and fast moving pace Microsoft have gotten into, we will see more frequent updates to PowerShell than before. Due to this, the PowerShell version number isn’t simply 5.0 anymore as you might have expected. Now it’s a full build number, such as 5.0.10586.117 for the RTM release of Windows Management Framework 5 for downlevel operating systems.

Because of this difficulty, the PSVersion module was created. It contains the Get-PSVersion function, which can read a mapping table and convert the PSVersion property to a “PSFriendlyVersionName” which makes more sense to a user.

You can read more about the background and see examples in the following article on PowerShell Magazine:
http://www.powershellmagazine.com/2016/03/10/decoding-powershell-build-numbers

There is also a TechNet Wiki site called Windows PowerShell build numbers, created as a reference for those who don`t want to leverage the PSVersion module:
http://social.technet.microsoft.com/wiki/contents/articles/33573.windows-powershell-build-numbers.aspx

The goal is to keep the Wiki-article in sync with the version mapping table in the PSVersion module.
