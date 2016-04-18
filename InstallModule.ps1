$ModuleName   = "PSVersion"
$ModulePath   = "C:\Program Files\WindowsPowerShell\Modules"
$TargetPath = "$($ModulePath)\$($ModuleName)"

if(!(Test-Path $TargetPath)) { md $TargetPath | out-null}

$targetFiles = echo `
    *.json `
    *.psm1 `
    *.psd1

    
Get-ChildItem -Path $targetFiles | 
    ForEach {
        Copy-Item -Verbose -Path $_.FullName -Destination $TargetPath #"$($TargetPath)\$($_.name)"
    }

if(!(Test-Path $TargetPath\Functions)) { md $TargetPath\Functions | out-null}

$targetFiles = echo `
    Functions

    
Get-ChildItem -Path $targetFiles | 
    ForEach {
        Copy-Item -Verbose -Path $_.FullName -Destination (Join-Path -Path $TargetPath -ChildPath Functions)
    }