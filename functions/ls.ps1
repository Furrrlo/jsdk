function Get-AllJsdks {
	$jsdk_home = [Environment]::GetEnvironmentVariable('JSDK_HOME')
	if($jsdk_home -eq "") {
		echo "Missing JSDK_HOME";
		return;
	}

	New-Item -Path $jsdk_home -Name "jdks" -ItemType "directory" -Force > $null
	
	$jdks = @()
	Get-ChildItem -Path ($jsdk_home + "\jdks\*") -Include "*.jdk" | 
	Foreach-Object {
		$content = Get-Content $_.FullName
		$jdks += [PSCustomObject]@{
			Name = $_.Name.Substring(0, $_.Name.length - ".jdk".length)
            Path = $content
        }
	}
	
	$jdks | Format-Table 
}

Set-Alias jsdk-ls Get-AllJsdks
