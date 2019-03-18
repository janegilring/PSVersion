# PSVersion
## about_PSVersion

# SHORT DESCRIPTION
Articfacts for PowerShell build numbers

# LONG DESCRIPTION
Until PowerShell 5.0 was released as part of Windows Management Framework 5.0, the build number was rounded to .0, such as 1.0, 2.0, 3.0, and 4.0. However, in this new and fast moving pace Microsoft have gotten into, we will see more frequent updates to PowerShell than before. Due to this, the PowerShell version number isn’t simply 5.0 anymore as you might have expected. Now it’s a full build number, such as 5.0.10586.117 for the RTM release of Windows Management Framework 5 for downlevel operating systems.

Because of this difficulty, the PSVersion module was created. It contains the Get-PSVersion function, which can read a mapping table and convert the PSVersion property to a “PSFriendlyVersionName” which makes more sense to a user.

# SEE ALSO
https://github.com/janegilring/PSVersion
