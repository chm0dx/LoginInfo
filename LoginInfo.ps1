$a = [ADSI]"WinNT://$env:COMPUTERNAME"
$lslo = (Get-Eventlog security -InstanceId 4624 | Where-Object {$_.ReplacementStrings[5] -eq $env:USERNAME})[1] | Select-Object -ExpandProperty TimeGenerated
$lflo = (Get-Eventlog security -InstanceId 4625 | Where-Object {$_.ReplacementStrings[5] -eq $env:USERNAME})[0] | Select-Object -ExpandProperty TimeGenerated
$ba = $a.Children | Where-Object {$_.SchemaClassName -eq 'user'} | Where-Object {$_.name -eq $env:USERNAME} | Select-Object -ExpandProperty BadPasswordAttempts
$ws = New-Object -ComObject Wscript.Shell
$msg = "Last Successful Login:`t`t$lslo`r`nLast Failed Login:`t`t`t$lflo`r`nCurrent Failed Attempts:`t`t$ba"
$ws.Popup($msg,0,"Login Info",0x1)
