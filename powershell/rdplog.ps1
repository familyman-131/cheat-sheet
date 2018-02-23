$time = [int](New-TimeSpan ([datetime]::Today) (get-date)).TotalMilliseconds
$filter = "*[System[TimeCreated[timediff(@SystemTime) < $time] and EventID=4624] and EventData[Data[@Name='LogonType']=10]]"
Get-WinEvent -FilterXPath $filter -LogName Security | Foreach {
$evt = $_
$addr = $evt.Properties[18].Value
$textcolor = $host.ui.rawui.foregroundcolor
$host.ui.rawui.foregroundcolor = "red"

if ($addr -like "192.168.0*") {$host.ui.rawui.foregroundcolor = "DarkGreen"}
if ($addr -like "10.*") {$host.ui.rawui.foregroundcolor = "yellow"}
"" | Select-Object @{n="Time";e={$evt.TimeCreated}},@{n="UserName";e={$evt.Properties[5].Value}},@{n="Address";e={$addr}}
$host.ui.rawui.foregroundcolor = $textcolor
} | sort -Desc  UserName 

# sort -Desc  UserName 
# or
# sort -Desc -unique UserName 