
$functions = {
        function FOO { 
            Start-Sleep -s 10
            write-host "FOO" 
        }
        function BOO { 
            Start-Sleep -s 1
            write-host "BOO" 
        }
    }



$X = 2, 4, 6, 8, 9, 20, 5
$XList = [System.Collections.ArrayList]$X

#Write-Host $XList
$Jobs = 3
#$num = 1 ; $num -le $XList.Length ; $num++
$Size = $XList.Count
for ($num = 0 ; $num -le $Size; $num++) {
    Do {
        $Job = (Get-Job -State Running | Measure-Object).count
        #Write-Host $Job
    } 
    Until ($Job -lt $Jobs)
    Start-Job -InitializationScript $functions -ScriptBlock {FOO}
    Write-Host "Started $num out of  $Size "
    Do {
         $Job = (Get-Job -State Running | Measure-Object).count
         #Write-Host $Job
    } 
    Until ($Job -lt $Jobs)
    
    $num++;
    Start-Job -InitializationScript $functions -ScriptBlock {BOO}
   Write-Host "Started $num out of  $Size "
    #Wait-Job * | Out-Null
    #$a | Wait-Job| Receive-Job
    #$b | Wait-Job| Receive-Job
}
Remove-Job -State Completed
Wait-Job * | Out-Null
Write-Host "All Jobs Complete"

