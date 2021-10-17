$job = Start-Job { Write-Host "Test";
Start-Sleep 3; } -Name "HelloJob"

Get-Job HelloJob

$jobEvent = Register-ObjectEvent $job StateChanged -Action {
    Write-Host ('Job #{0} ({1}) complete.' -f $sender.Id, $sender.Name)
    $jobEvent | Unregister-Event
}


