net session > $null 2>&1;
if (-not $?) {
	echo "Administrative permissions required."
	exit 1
}

$jsdk_home = [System.Environment]::CurrentDirectory;
[Environment]::SetEnvironmentVariable('JSDK_HOME', $jsdk_home, 'Machine');
Set-Item "Env:Path" -Value $jsdk_home;

$jsdk_junction = "C:\ProgramData\Oracle\Java\javapath-junction";
[Environment]::SetEnvironmentVariable('JSDK_JUNCTION', $jsdk_junction, 'Machine');
Set-Item "Env:Path" -Value $jsdk_junction;

# https://stackoverflow.com/a/52621557
$oldPath = (Get-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" ).
  GetValue('Path', '', 'DoNotExpandEnvironmentNames');

$newPath = $oldPath;
if(-not $oldPath.Contains("%JSDK_JUNCTION%")) {
	$newPath = "$oldPath;%JSDK_JUNCTION%\bin\";
}

[Environment]::SetEnvironmentVariable('Path', $newPath, 'Machine');
Set-Item "Env:Path" -Value $newPath;

$sourceProfile="if (Test-Path (`$env:JSDK_HOME + `"\profile.psm1`")) { Import-Module (`$env:JSDK_HOME + `"\profile.psm1`") }";

if (-not $(Test-Path $profile)) {
    New-Item -Path $profile -Type File -Force | Out-Null;
}

if ("$(Get-Content $profile | Select-String "JSDK_HOME")" -eq "") {
    Write-Host "Adding source string to $profile";
    "`n$sourceProfile`n" | Out-File -Append -Encoding ASCII $profile;
}

Import-Module ($jsdk_home + "\profile.psm1");