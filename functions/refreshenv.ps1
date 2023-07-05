function Update-RefreshJsdkEnv {
	$newPath = (Get-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" ).
	  GetValue('JAVA_HOME', '', 'None')
	Set-Item "Env:JAVA_HOME" -Value $newPath
}

Set-Alias jsdk-refreshenv Update-RefreshJsdkEnv