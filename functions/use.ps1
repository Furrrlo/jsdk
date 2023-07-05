function Use-Jsdk {
	param(
		[Parameter(Position=0, Mandatory=$true)][string]$JdkName
	);

	$jsdk_home = [Environment]::GetEnvironmentVariable('JSDK_HOME');
	if($jsdk_home -eq "") {
		echo "Missing JSDK_HOME";
		return;
	}

	$jsdk_junction = [Environment]::GetEnvironmentVariable('JSDK_JUNCTION');
	if($jsdk_junction -eq "") {
		echo "Missing JSDK_JUNCTION";
		return;
	}

	$jdk_file_path = $jsdk_home + "\jdks\" + $JdkName + ".jdk"
	if(-not (Test-Path -Path $jdk_file_path)) {
		echo ("No JDK named " + $JdkName + " was linked");
		return;
	}

	$jdk_path = Get-Content $jdk_file_path;
	if(-not (Test-Path -Path $jdk_path)) {
		echo ("JDK at '" + $jdk_path + "' no longer exists, aborting");
		return;
	}

	net session > $null 2>&1;
	if (-not $?) {
		echo "Administrative permissions required.";
		return;
	}

	[Environment]::SetEnvironmentVariable('JAVA_HOME', $jdk_path, 'Machine');
	Set-Item "Env:JAVA_HOME" -Value $jdk_path;

	[io.directory]::Delete($jsdk_junction);
	New-Item -Type Junction -Path $jsdk_junction -Target $jdk_path > $null;
}

Set-Alias jsdk-use Use-Jsdk