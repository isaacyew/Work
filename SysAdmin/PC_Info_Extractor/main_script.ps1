function Decode {
    If ($args[0] -is [System.Array]) {
        [System.Text.Encoding]::ASCII.GetString($args[0])
    }
    Else {
        "Contact your Lead"
    }
}

$LogFile = "$($env:USERPROFILE)\Desktop\PC_Info.txt"

$Manufacturer = (Get-WmiObject -Class "Win32_computersystem" | Format-List -Property Manufacturer | out-string).Trim()
$SysFam = (Get-WmiObject -Class "Win32_computersystem" | Format-List -Property SystemFamily | out-string).Trim()
$Model = (Get-WmiObject -Class "Win32_computersystem" | Format-List -Property Model | out-string).Trim()
$Serial = (Get-WmiObject win32_bios | Format-List -Property Serialnumber | out-string).Trim()
$Name = (Get-WmiObject -Class "Win32_computersystem" | Format-List -Property Name | out-string).Trim()
$Hostname = (Get-WmiObject -Class "Win32_computersystem" | Format-List -Property DNSHostname | out-string).Trim()
$Username = $env:UserName


"This is your PC info:,`n" | Out-File $LogFile
"$Manufacturer," | Out-File $LogFile -append
"$SysFam," | Out-File $LogFile -append
"$Model," | Out-File $LogFile -append
"$Serial," | Out-File $LogFile -append
"$Name," | Out-File $LogFile -append
"$Hostname," | Out-File $LogFile -append
"Username: $Username," | Out-File $LogFile -append

$Monitors = Get-WmiObject WmiMonitorID -Namespace root\wmi

"Monitor Info:,`nManufacturer-Name-Serial," | Out-File $LogFile -append

ForEach ($Monitor in $Monitors)
{
	$Manufacturer = ($Monitor.ManufacturerName -notmatch 0 | ForEach{[char]$_}) -join ""
	$Name = ($Monitor.UserFriendlyName -notmatch 0 | ForEach{[char]$_}) -join ""
	$Serial = ($Monitor.SerialNumberID -notmatch 0 | ForEach{[char]$_}) -join ""
	
	"$Manufacturer,$Name,$Serial" | Out-File $LogFile -append
}