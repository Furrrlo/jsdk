function Add-Jsdk {
	param(
		[Parameter(Position=0, Mandatory=$true)][string]$JdkName,
		[Parameter(Position=1, Mandatory=$true)][string]$JdkPath
	)

	$jsdk_home = [Environment]::GetEnvironmentVariable('JSDK_HOME')
	if($jsdk_home -eq "") {
		echo "Missing JSDK_HOME";
		return;
	}

	if(-not (Test-Path -Path $JdkPath)) {
		echo ("Path '" + $JdkPath + "' does not exist");
		return;
	}

	New-Item -Path $jsdk_home -Name "jdks" -ItemType "directory" -Force > $null

	$file_path = $jsdk_home + "\jdks\" + $JdkName + ".jdk"
	Set-Content -Path $file_path -Value $JdkPath > $null
}

Set-Alias jsdk-add Add-Jsdk