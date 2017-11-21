


function Add-ApplicationPool {
    param(
        [String[]] $ComputersName,
        [String] $ApplicationPoolName
    )

    $sessions = $ComputersName | ForEach-Object { New-PSSession -ComputerName $_ }
    $jobs = $sessions | ForEach-Object {
        Invoke-Command -Session $_ -ScriptBlock {
            "Estamos executando os comandos no computador: $env:COMPUTERNAME"
            $appCmdArgs = "add apppool /name:$($args[0]) /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated"
            C:\Windows\System32\inetsrv\appcmd.exe $appCmdArgs.Split(' ')
        } -ArgumentList $ApplicationPoolName -AsJob
    }

    $jobs | Wait-Job | Select-Object @{Expression={ Receive-Job $_ };Label="Resultado"},"Name"
    $jobs | Remove-Job
    $sessions | Remove-PSSession    
}

