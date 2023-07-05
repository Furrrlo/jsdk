$thisDirectory = (Split-Path -parent $MyInvocation.MyCommand.Definition);

. $thisDirectory\functions\add.ps1
. $thisDirectory\functions\curr.ps1
. $thisDirectory\functions\ls.ps1
. $thisDirectory\functions\refreshenv.ps1
. $thisDirectory\functions\use.ps1

Export-ModuleMember -Alias jsdk-add -Function 'Add-Jsdk';
Export-ModuleMember -Alias jsdk-curr -Function 'Get-CurrentJsdk';
Export-ModuleMember -Alias jsdk-ls -Function 'Get-AllJsdks';
Export-ModuleMember -Alias jsdk-refreshenv -Function 'Update-RefreshJsdkEnv';
Export-ModuleMember -Alias jsdk-use -Function 'Use-Jsdk';