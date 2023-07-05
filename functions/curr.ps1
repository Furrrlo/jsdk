function Get-CurrentJsdk {
	$jsdk_home = [Environment]::GetEnvironmentVariable('JSDK_HOME')
	if($jsdk_home -eq "") {
		echo "Missing JSDK_HOME";
		return;
	}

	New-Item -Path $jsdk_home -Name "jdks" -ItemType "directory" -Force > $null

	$curr_jvm = [Environment]::GetEnvironmentVariable('JAVA_HOME');

	Get-ChildItem -Path ($jsdk_home + "\jdks\*") -Include "*.jdk" | 
	Foreach-Object {
		$content = Get-Content $_.FullName
		
		if($curr_jvm -eq $content) {
			echo ($_.Name.Substring(0, $_.Name.length - ".jdk".length)  + ' - ' + $content)
		}
	}
}

Set-Alias jsdk-curr Get-CurrentJsdk
