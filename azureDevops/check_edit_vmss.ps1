#### CONFIGURAZIONE ####

$AzureDevOpsPAT       = "PAToc"
$OrganizationName     = "organizationame"
$UriOrga              = "https://dev.azure.com/$OrganizationName/"

$AuthHeader = @{
    Authorization  = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$AzureDevOpsPAT"))
    'Content-Type' = 'application/json'
}

# DEFINISCI QUI LE TUE PIPELINE
# Formato: @{ Project = "NomeProgetto"; PipelineId = 123 }
$PipelinesToTrigger = @(
    @{ Project = "O2X-DWT";                    PipelineId = 59  },
    @{ Project = "O2X-DWT";                    PipelineId = 178 },
    @{ Project = "O2X-DWT";                    PipelineId = 58  },
    @{ Project = "O2X-DWT";                    PipelineId = 177 },
    @{ Project = "O2X-DWT";                    PipelineId = 57  },
    @{ Project = "O2X-BPSAPPS";               PipelineId = 84  },
    @{ Project = "O2X-BPSAPPS";               PipelineId = 81  },
    @{ Project = "O2X-BPSPURVIEW";            PipelineId = 85  },
    @{ Project = "O2X-MARKETINGAPP";          PipelineId = 113 },
    @{ Project = "O2X-MARKETINGAPP";          PipelineId = 114 },
    @{ Project = "O2X-Controlroom";           PipelineId = 80  },
    @{ Project = "O2X-NVLTOOLS";              PipelineId = 37  },
    @{ Project = "O2X-NVLTOOLS";              PipelineId = 148 },
    @{ Project = "O2X-KRATEO";               PipelineId = 76  },
    @{ Project = "O2X-SGRAPPS";              PipelineId = 110 },
    @{ Project = "O2X-SGRAPPS";              PipelineId = 111 },
    @{ Project = "O2X-Opentol";              PipelineId = 149 },
    @{ Project = "O2X-SBRAPPS";              PipelineId = 68  },
    @{ Project = "O2X-SBRAPPS";              PipelineId = 69  },
    @{ Project = "O2X-BSEBUSINTELL";         PipelineId = 79  },
    @{ Project = "O2X-CTDUMA";               PipelineId = 104 },
    @{ Project = "O2X-CTDUMA";               PipelineId = 103 },
    @{ Project = "O2X-COMMONSERVICES";       PipelineId = 124 },
    @{ Project = "O2X-CNTInvestimenti";      PipelineId = 105 },
    @{ Project = "O2X-CNTInvestimenti";      PipelineId = 106 },
    @{ Project = "O2X-CNTInvestimenti";      PipelineId = 108 },
    @{ Project = "O2X-SYSOPS";              PipelineId = 70  },
    @{ Project = "O2X-BSHOPENAI";           PipelineId = 93  },
    @{ Project = "O2X-BSHOPENAI";           PipelineId = 86  },
    @{ Project = "O2X-Security";            PipelineId = 101 },
    @{ Project = "O2X-Security";            PipelineId = 100 },
    @{ Project = "O2X-Security";            PipelineId = 99  },
    @{ Project = "O2X-CENTRICOSQL";         PipelineId = 88  },
    @{ Project = "O2X-CENTRICOSQL";         PipelineId = 87  },
    @{ Project = "O2X-SELLA";               PipelineId = 12  },
    @{ Project = "O2X-SELLA";               PipelineId = 7   },
    @{ Project = "O2X-SELLA";               PipelineId = 9   },
    @{ Project = "O2X-SELLA";               PipelineId = 8   },
    @{ Project = "O2X-SLAPPS";              PipelineId = 62  },
    @{ Project = "O2X-SLAPPS";              PipelineId = 63  },
    @{ Project = "O2X-SLAPPS";              PipelineId = 71  },
    @{ Project = "O2X-BNKFND";             PipelineId = 60  },
    @{ Project = "O2X-BNKFND";             PipelineId = 61  },
    @{ Project = "O2X-CNTInformatica";      PipelineId = 73  },
    @{ Project = "O2X-CNTInformatica";      PipelineId = 72  },
    @{ Project = "O2X-BusinessIntelligence"; PipelineId = 65 },
    @{ Project = "O2X-BusinessIntelligence"; PipelineId = 67 },
    @{ Project = "O2X-BusinessIntelligence"; PipelineId = 66 },
    @{ Project = "O2X-BPSBUSINTELL";        PipelineId = 64  },
    @{ Project = "O2X-HYPE";               PipelineId = 15  },
    @{ Project = "O2X-NVLPOC";             PipelineId = 40  },
    @{ Project = "O2X-NVLPOC";             PipelineId = 43  },
    @{ Project = "O2X-NVLPOC";             PipelineId = 55  },
    @{ Project = "O2X-NVLPOC";             PipelineId = 50  },
    @{ Project = "O2X-NVLPOC";             PipelineId = 42  },
    @{ Project = "O2X-CRYPTOCUSTODY";       PipelineId = 98  },
    @{ Project = "O2X-CRYPTOCUSTODY";       PipelineId = 97  },
    @{ Project = "O2X-SLRAPPS";            PipelineId = 36  },
    @{ Project = "O2X-SLRAPPS";            PipelineId = 78  },
    @{ Project = "O2X-BSHBusinessIntelligence"; PipelineId = 34 },
    @{ Project = "O2X-NVLMONITORING";      PipelineId = 118 },
    @{ Project = "O2X-SPCAPPS";            PipelineId = 95  },
    @{ Project = "O2X-SPCAPPS";            PipelineId = 96  },
    @{ Project = "O2X-BSEAPPS";            PipelineId = 160 },
    @{ Project = "O2X-BSEAPPS";            PipelineId = 159 },
    @{ Project = "O2X-BSEAPPS";            PipelineId = 163 },
    @{ Project = "O2X-DEVOPS";             PipelineId = 162 },
    @{ Project = "O2X-CANALI";             PipelineId = 90  },
    @{ Project = "O2X-CANALI";             PipelineId = 91  },
    @{ Project = "O2X-CANALI";             PipelineId = 92  },
    @{ Project = "O2X-ArchitettureAI";     PipelineId = 161 },
    @{ Project = "O2X-ArchitettureAI";     PipelineId = 152 },
    @{ Project = "O2X-ArchitettureAI";     PipelineId = 151 },
    @{ Project = "O2X-Tol";               PipelineId = 82  },
    @{ Project = "O2X-Tol";               PipelineId = 83  },
    @{ Project = "O2X-Foundation";         PipelineId = 133 },
	@{ Project = "O2X-Foundation";         PipelineId = 139 },
    @{ Project = "O2X-Foundation";         PipelineId = 5   },
    @{ Project = "O2X-Foundation";         PipelineId = 13  },
    @{ Project = "O2X-Foundation";         PipelineId = 6   },
    @{ Project = "O2X-Foundation";         PipelineId = 3   },
    @{ Project = "O2X-Foundation";         PipelineId = 136 },
    @{ Project = "O2X-Foundation";         PipelineId = 134 },
    @{ Project = "O2X-Foundation";         PipelineId = 135 },
    @{ Project = "O2X-Foundation";         PipelineId = 137 },
    @{ Project = "O2X-Foundation";         PipelineId = 138 },
    @{ Project = "O2X-Foundation";         PipelineId = 120 },
    @{ Project = "O2X-Foundation";         PipelineId = 122 },
    @{ Project = "O2X-Foundation";         PipelineId = 121 },
    @{ Project = "O2X-Foundation";         PipelineId = 131 },
    @{ Project = "O2X-Foundation";         PipelineId = 132 },
    @{ Project = "O2X-Foundation";         PipelineId = 130 },
    @{ Project = "O2X-Foundation";         PipelineId = 126 },
    @{ Project = "O2X-Foundation";         PipelineId = 125 }
)

# Workload pipeline
$PipelineWorkloads = @(
    @{ Project = "O2X-Foundation"; PipelineId = 140 }
)

$WorkloadNames = @(
    "ado", "architettureai", "bankingfoundation", "commonservices",
    "controlroom", "cryptocustody", "ctduma", "dbaudit", "devops",
    "dmzinterna", "dwt", "informatica", "investimenti", "krateo",
    "marketingapp", "monetica", "monitoring", "nvlpoc", "nvltools",
    "openai", "opentol", "remoteaccess", "sbrapps", "security",
    "sgrapps", "slapps", "slrapps", "spcapps", "spokevnet", "sysops", "tol"
)

$BatchSizeWorkload = 7


# Ambienti suddivisi per "tier"
$EnvPro   = @("pro")
$EnvLower = @("uat", "tst", "dev")

# Azione
$Action = "Plan"

# Batch separati per tier
$BatchSizePro   = 7
$BatchSizeLower = 7

# Polling e timeout
$PollingIntervalSeconds = 15
$TimeoutMinutes         = 30

#########################################################################

function Start-Pipeline {
    param(
        [string]$ProjectName,
        [int]$PipelineId,
        [string]$Environment,
        [string]$Action
    )

    $uri  = "$UriOrga$ProjectName/_apis/pipelines/$PipelineId/runs?api-version=7.1-preview.1"
    $body = @{
        templateParameters = @{
            Action      = $Action
            Environment = $Environment
        }
    } | ConvertTo-Json -Depth 5

    try {
        $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $AuthHeader -Body $body
        return [PSCustomObject]@{
            Project     = $ProjectName
            PipelineId  = $PipelineId
            Environment = $Environment
            RunId       = $response.id
            RunName     = $response.name
            StartTime   = Get-Date
            EndTime     = $null
            State       = "inProgress"
            Result      = $null
            Duration    = $null
            Error       = $null
        }
    }
    catch {
        $errorBody = $_.ErrorDetails.Message | ConvertFrom-Json -ErrorAction SilentlyContinue
        return [PSCustomObject]@{
            Project     = $ProjectName
            PipelineId  = $PipelineId
            Environment = $Environment
            RunId       = $null
            RunName     = $null
            StartTime   = Get-Date
            EndTime     = $null
            State       = "failedToStart"
            Result      = "error"
            Duration    = $null
            Error       = "$($_.Exception.Message) | Detail: $($errorBody.message)"
        }
    }
}

function Get-RunStatus {
    param(
        [string]$ProjectName,
        [int]$PipelineId,
        [int]$RunId
    )
    $uri = "$UriOrga$ProjectName/_apis/pipelines/$PipelineId/runs/$RunId`?api-version=7.1-preview.1"
    try { return Invoke-RestMethod -Uri $uri -Method Get -Headers $AuthHeader }
    catch { return $null }
}

# Polling su un set di run finché tutte non sono terminate
function Wait-ForBatch {
    param(
        [array]$BatchRuns,
        [string]$Label
    )

    $timeout = (Get-Date).AddMinutes($TimeoutMinutes)

    do {
        Start-Sleep -Seconds $PollingIntervalSeconds

        $pending = $BatchRuns | Where-Object { $_.State -notin @("completed","failedToStart") -and $null -ne $_.RunId }

        foreach ($run in $pending) {
            $status = Get-RunStatus -ProjectName $run.Project -PipelineId $run.PipelineId -RunId $run.RunId
            if ($status -and $status.state -eq "completed") {
                $run.State    = "completed"
                $run.Result   = $status.result
                $run.EndTime  = Get-Date
                $run.Duration = $run.EndTime - $run.StartTime
                Write-Host "   [$Label] Completata | $($run.Project) | Env: $($run.Environment) | RunId: $($run.RunId) | Result: $($run.Result) | $("{0:D2}:{1:D2}:{2:D2}" -f $run.Duration.Hours, $run.Duration.Minutes, $run.Duration.Seconds)"
            }
        }

        $stillPending = ($BatchRuns | Where-Object { $_.State -notin @("completed","failedToStart") -and $null -ne $_.RunId }).Count
        Write-Host "   [$Label] In attesa di $stillPending pipeline... [$(Get-Date -Format 'HH:mm:ss')]"

    } while ($stillPending -gt 0 -and (Get-Date) -lt $timeout)

    if ((Get-Date) -ge $timeout) {
        Write-Host "`n  [$Label] TIMEOUT raggiunto."
        foreach ($run in $BatchRuns | Where-Object { $_.State -notin @("completed","failedToStart") }) {
            $run.State  = "timeout"
            $run.Result = "unknown"
        }
    }
}

# Costruisce lista combinazioni pipeline x ambienti, poi la suddivide in batch
function Build-Batches {
    param(
        [array]$Pipelines,
        [array]$Environments,
        [int]$BatchSize
    )

    $combinations = @()
    foreach ($env in $Environments) {
        foreach ($pipe in $Pipelines) {
            $combinations += @{ Pipe = $pipe; Env = $env }
        }
    }

    $batches = @()
    $total   = $combinations.Count
    for ($i = 0; $i -lt $total; $i += $BatchSize) {
        $end     = [math]::Min($i + $BatchSize - 1, $total - 1)
        $batches += , ($combinations[$i..$end])
    }
    return $batches
}

function Start-PipelineWorkload {
    param(
        [string]$ProjectName,
        [int]$PipelineId,
        [string]$Environment,
        [string]$Action,
        [string]$Workload
    )

    $uri  = "$UriOrga$ProjectName/_apis/pipelines/$PipelineId/runs?api-version=7.1-preview.1"
    $body = @{
        templateParameters = @{
            Action      = $Action
            Environment = $Environment
            Workload    = $Workload    # ← verifica che il nome combaci col parametro della pipeline
        }
    } | ConvertTo-Json -Depth 5

    try {
        $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $AuthHeader -Body $body
        return [PSCustomObject]@{
            Project     = $ProjectName
            PipelineId  = $PipelineId
            Environment = $Environment
            Workload    = $Workload
            RunId       = $response.id
            RunName     = $response.name
            StartTime   = Get-Date
            EndTime     = $null
            State       = "inProgress"
            Result      = $null
            Duration    = $null
            Error       = $null
        }
    }
    catch {
        $errorBody = $_.ErrorDetails.Message | ConvertFrom-Json -ErrorAction SilentlyContinue
        return [PSCustomObject]@{
            Project     = $ProjectName
            PipelineId  = $PipelineId
            Environment = $Environment
            Workload    = $Workload
            RunId       = $null
            RunName     = $null
            StartTime   = Get-Date
            EndTime     = $null
            State       = "failedToStart"
            Result      = "error"
            Duration    = $null
            Error       = "$($_.Exception.Message) | Detail: $($errorBody.message)"
        }
    }
}

function Build-BatchesWorkload {
    param(
        [array]$Pipelines,
        [array]$Environments,
        [array]$Workloads,
        [int]$BatchSize
    )

    $combinations = @()
    foreach ($env in $Environments) {
        foreach ($pipe in $Pipelines) {
            foreach ($wl in $Workloads) {
                $combinations += @{ Pipe = $pipe; Env = $env; Workload = $wl }
            }
        }
    }

    $batches = @()
    $total   = $combinations.Count
    for ($i = 0; $i -lt $total; $i += $BatchSize) {
        $end     = [math]::Min($i + $BatchSize - 1, $total - 1)
        $batches += , ($combinations[$i..$end])
    }
    return $batches
}

#########################################################################

$globalStart = Get-Date
$allRuns     = @()

# ── Scriptblock autonomo per i workload (gira in background in parallelo) ──
$sbWorkload = {
    param([hashtable]$Cfg, [array]$Batches, [string]$Label)

    $UriOrga                = $Cfg.UriOrga
    $AuthHeader             = $Cfg.AuthHeader
    $PollingIntervalSeconds = $Cfg.PollingInterval
    $TimeoutMinutes         = $Cfg.Timeout

    function Get-RunStatus {
        param([string]$ProjectName, [int]$PipelineId, [int]$RunId)
        $uri = "$UriOrga$ProjectName/_apis/pipelines/$PipelineId/runs/$RunId`?api-version=7.1-preview.1"
        try { return Invoke-RestMethod -Uri $uri -Method Get -Headers $AuthHeader }
        catch { return $null }
    }

    function Wait-ForBatchWL {
        param([object[]]$BatchRuns, [string]$BatchLabel)
        $timeout = (Get-Date).AddMinutes($TimeoutMinutes)
        do {
            Start-Sleep -Seconds $PollingIntervalSeconds
            $pending = $BatchRuns | Where-Object { $_.State -notin @("completed","failedToStart") -and $null -ne $_.RunId }
            foreach ($run in $pending) {
                $status = Get-RunStatus -ProjectName $run.Project -PipelineId $run.PipelineId -RunId $run.RunId
                if ($status -and $status.state -eq "completed") {
                    $now = Get-Date
                    $run.Duration = $now - $run.StartTime
                    $run.State    = "completed"
                    $run.Result   = $status.result
                    $run.EndTime  = $now
                    Write-Output "   [$BatchLabel] Completata | $($run.Project) | Workload: $($run.Workload) | Env: $($run.Environment) | RunId: $($run.RunId) | Result: $($run.Result) | $("{0:D2}:{1:D2}:{2:D2}" -f $run.Duration.Hours,$run.Duration.Minutes,$run.Duration.Seconds)"
                }
            }
            $stillPending = ($BatchRuns | Where-Object { $_.State -notin @("completed","failedToStart") -and $null -ne $_.RunId }).Count
            Write-Output "   [$BatchLabel] In attesa di $stillPending workload... [$(Get-Date -Format 'HH:mm:ss')]"
        } while ($stillPending -gt 0 -and (Get-Date) -lt $timeout)
        if ((Get-Date) -ge $timeout) {
            Write-Output "`n  [$BatchLabel] TIMEOUT raggiunto."
            foreach ($run in $BatchRuns | Where-Object { $_.State -notin @("completed","failedToStart") }) {
                $run.State = "timeout"; $run.Result = "unknown"
            }
        }
    }

    $allRuns  = [System.Collections.Generic.List[object]]::new()
    $batchNum = 0
    foreach ($batch in $Batches) {
        $batchNum++
        Write-Output "`n  [$Label] Batch $batchNum / $($Batches.Count)  |  $(Get-Date -Format 'HH:mm:ss')"
        $batchRuns = [System.Collections.Generic.List[object]]::new()
        foreach ($item in $batch) {
            $uri  = "$UriOrga$($item.Pipe.Project)/_apis/pipelines/$($item.Pipe.PipelineId)/runs?api-version=7.1-preview.1"
            $body = @{ templateParameters = @{ Action = $Cfg.Action; Environment = $item.Env; Workload = $item.Workload } } | ConvertTo-Json -Depth 5
            try {
                $resp = Invoke-RestMethod -Uri $uri -Method Post -Headers $AuthHeader -Body $body
                $run  = [PSCustomObject]@{
                    Project = $item.Pipe.Project; PipelineId = $item.Pipe.PipelineId
                    Environment = $item.Env; Workload = $item.Workload
                    RunId = $resp.id; RunName = $resp.name; StartTime = Get-Date; EndTime = $null
                    State = "inProgress"; Result = $null; Duration = $null; Error = $null
                }
                Write-Output "   [$Label] Avviata  | $($run.Project) | ID: $($run.PipelineId) | Workload: $($item.Workload) | Env: $($item.Env) | RunId: $($run.RunId)"
            } catch {
                $eb  = $_.ErrorDetails.Message | ConvertFrom-Json -ErrorAction SilentlyContinue
                $run = [PSCustomObject]@{
                    Project = $item.Pipe.Project; PipelineId = $item.Pipe.PipelineId
                    Environment = $item.Env; Workload = $item.Workload
                    RunId = $null; RunName = $null; StartTime = Get-Date; EndTime = $null
                    State = "failedToStart"; Result = "error"; Duration = $null
                    Error = "$($_.Exception.Message) | Detail: $($eb.message)"
                }
                Write-Output "   [$Label] Errore   | $($run.Project) | ID: $($run.PipelineId) | Workload: $($item.Workload) | Env: $($item.Env) | $($run.Error)"
            }
            $batchRuns.Add($run); $allRuns.Add($run)
        }
        Wait-ForBatchWL -BatchRuns $batchRuns.ToArray() -BatchLabel $Label
        Write-Output "  [$Label] Batch $batchNum completato."
    }
    foreach ($r in $allRuns) { $r }
}

# ── Costruisce i batch workload e avvia i job in background ──
$batchesWorkloadPro   = Build-BatchesWorkload -Pipelines $PipelineWorkloads -Environments $EnvPro   -Workloads $WorkloadNames -BatchSize $BatchSizeWorkload
$batchesWorkloadLower = Build-BatchesWorkload -Pipelines $PipelineWorkloads -Environments $EnvLower -Workloads $WorkloadNames -BatchSize $BatchSizeWorkload

$cfgWL = @{
    UriOrga         = $UriOrga
    AuthHeader      = $AuthHeader
    PollingInterval = $PollingIntervalSeconds
    Timeout         = $TimeoutMinutes
    Action          = $Action
}

Write-Host "`n  [WORKLOAD] Avvio job background — PRO ($($batchesWorkloadPro.Count) batch) + LOWER ($($batchesWorkloadLower.Count) batch)"
$jobWorkloadPro   = Start-Job -ScriptBlock $sbWorkload -ArgumentList $cfgWL, $batchesWorkloadPro,   "WL-PRO"
$jobWorkloadLower = Start-Job -ScriptBlock $sbWorkload -ArgumentList $cfgWL, $batchesWorkloadLower, "WL-LOWER"
Write-Host "  [WORKLOAD] Job avviati — WL-PRO (ID:$($jobWorkloadPro.Id)) | WL-LOWER (ID:$($jobWorkloadLower.Id))`n"

# ── Costruisce i batch separati ──
$batchesPro   = Build-Batches -Pipelines $PipelinesToTrigger -Environments $EnvPro   -BatchSize $BatchSizePro
$batchesLower = Build-Batches -Pipelines $PipelinesToTrigger -Environments $EnvLower -BatchSize $BatchSizeLower

$totalProRun   = $PipelinesToTrigger.Count * $EnvPro.Count
$totalLowerRun = $PipelinesToTrigger.Count * $EnvLower.Count

Write-Host "`n=========================================================="
Write-Host "  AVVIO PIPELINE CON BATCH SEPARATI"
Write-Host "  PRO   : $totalProRun run  |  batch da $BatchSizePro  |  $($batchesPro.Count) batch"
Write-Host "  LOWER : $totalLowerRun run  |  batch da $BatchSizeLower  |  $($batchesLower.Count) batch"
Write-Host "  Action: $Action"
Write-Host "==========================================================`n"

# ── Esegue i batch PRO e LOWER in parallelo usando Job PowerShell ──
# Poiché i Job non condividono oggetti, gestiamo i due stream separatamente
# e li eseguiamo in sequenza per tier, ma i due tier girano uno dopo l'altro
# (PRO prima, poi LOWER) oppure puoi invertire l'ordine.
# Se vuoi davvero parallelismo tra i due tier devi usare Start-Job;
# per semplicità e leggibilità qui li eseguiamo in sequenza per tier
# ma ENTRO ogni tier i 7 run sono contemporanei.

# ── Tier PRO ──
Write-Host "══════════ TIER: PRO ══════════"
$batchNumPro = 0
foreach ($batch in $batchesPro) {
    $batchNumPro++
    Write-Host "`n  [PRO] Batch $batchNumPro / $($batchesPro.Count)  |  $(Get-Date -Format 'HH:mm:ss')"

    $batchRuns = @()
    foreach ($item in $batch) {
        $run = Start-Pipeline -ProjectName $item.Pipe.Project -PipelineId $item.Pipe.PipelineId -Environment $item.Env -Action $Action
        if ($run.RunId) {
            Write-Host "   [PRO] Avviata  | $($run.Project) | ID: $($run.PipelineId) | Env: $($item.Env) | RunId: $($run.RunId)"
        } else {
            Write-Host "   [PRO] Errore   | $($run.Project) | ID: $($run.PipelineId) | Env: $($item.Env) | $($run.Error)"
        }
        $batchRuns += $run
        $allRuns   += $run
    }

    Wait-ForBatch -BatchRuns $batchRuns -Label "PRO"
    Write-Host "  [PRO] Batch $batchNumPro completato."
}

# ── Tier LOWER (uat / tst / dev) ──
Write-Host "`n══════════ TIER: LOWER (uat/tst/dev) ══════════"
$batchNumLower = 0
foreach ($batch in $batchesLower) {
    $batchNumLower++
    Write-Host "`n  [LOWER] Batch $batchNumLower / $($batchesLower.Count)  |  $(Get-Date -Format 'HH:mm:ss')"

    $batchRuns = @()
    foreach ($item in $batch) {
        $run = Start-Pipeline -ProjectName $item.Pipe.Project -PipelineId $item.Pipe.PipelineId -Environment $item.Env -Action $Action
        if ($run.RunId) {
            Write-Host "   [LOWER] Avviata  | $($run.Project) | ID: $($run.PipelineId) | Env: $($item.Env) | RunId: $($run.RunId)"
        } else {
            Write-Host "   [LOWER] Errore   | $($run.Project) | ID: $($run.PipelineId) | Env: $($item.Env) | $($run.Error)"
        }
        $batchRuns += $run
        $allRuns   += $run
    }

    Wait-ForBatch -BatchRuns $batchRuns -Label "LOWER"
    Write-Host "  [LOWER] Batch $batchNumLower completato."
}

# ── Attesa e raccolta risultati WORKLOAD ──
Write-Host "`n══════════ Attesa completamento WORKLOAD (WL-PRO + WL-LOWER) ══════════"
$allWorkloadRuns = @()
foreach ($job in @($jobWorkloadPro, $jobWorkloadLower)) {
    while ($job.State -in @("Running","NotStarted")) {
        $received = Receive-Job $job -ErrorAction SilentlyContinue
        foreach ($item in $received) {
            if ($item -is [string]) { Write-Host $item }
            else { $allWorkloadRuns += $item }
        }
        Start-Sleep -Seconds 5
    }
    # Flush finale
    $received = Receive-Job $job -ErrorAction SilentlyContinue
    foreach ($item in $received) {
        if ($item -is [string]) { Write-Host $item }
        else { $allWorkloadRuns += $item }
    }
    Remove-Job $job
}
Write-Host "  [WORKLOAD] Completato. $($allWorkloadRuns.Count) run raccolte.`n"

#########################################################################
$globalEnd      = Get-Date
$globalDuration = $globalEnd - $globalStart

Write-Host "`n=========================================================="
Write-Host "  REPORT FINALE"
Write-Host "==========================================================`n"

# ── Tabella completa ──
$allRuns | Sort-Object Environment, Project, Workload | Format-Table -AutoSize -Property `
    @{L="Project";    E={$_.Project}},
    @{L="PipelineId"; E={$_.PipelineId}},
    @{L="Workload";   E={$_.Workload}},
    @{L="Env";        E={$_.Environment}},
    @{L="RunId";      E={$_.RunId}},
    @{L="State";      E={$_.State}},
    @{L="Result";     E={$_.Result}},
    @{L="StartTime";  E={if($_.StartTime){$_.StartTime.ToString("HH:mm:ss")}else{""}}},
    @{L="EndTime";    E={if($_.EndTime){$_.EndTime.ToString("HH:mm:ss")}else{""}}},
    @{L="Duration";   E={if($_.Duration){"{0:D2}:{1:D2}:{2:D2}" -f $_.Duration.Hours,$_.Duration.Minutes,$_.Duration.Seconds}else{""}}}

# ── Calcoli globali ──
$completed  = $allRuns | Where-Object { $_.State -eq "completed" }
$succeeded  = $completed | Where-Object { $_.Result -eq "succeeded" }
$failed     = $completed | Where-Object { $_.Result -ne "succeeded" }
$notStarted = $allRuns | Where-Object { $_.State -eq "failedToStart" }
$timedOut   = $allRuns | Where-Object { $_.State -eq "timeout" }
$durations  = $completed | Where-Object { $null -ne $_.Duration } | Select-Object -ExpandProperty Duration

Write-Host "----------------------------------------------------------"
Write-Host "  RIEPILOGO GLOBALE"
Write-Host "----------------------------------------------------------"
Write-Host "  Totale run        : $($allRuns.Count)"
Write-Host "  Completate        : $($completed.Count)"
Write-Host "  Succeeded         : $($succeeded.Count)"
Write-Host "  Failed/Other      : $($failed.Count)"
Write-Host "  Failed to start   : $($notStarted.Count)"
Write-Host "  Timeout           : $($timedOut.Count)"

if ($durations.Count -gt 0) {
    $avgSeconds = ($durations | Measure-Object -Property TotalSeconds -Average).Average
    $minSeconds = ($durations | Measure-Object -Property TotalSeconds -Minimum).Minimum
    $maxSeconds = ($durations | Measure-Object -Property TotalSeconds -Maximum).Maximum
    Write-Host ("  Durata media      : {0:D2}:{1:D2}:{2:D2}" -f [int]($avgSeconds/3600),[int](($avgSeconds%3600)/60),[int]($avgSeconds%60))
    Write-Host ("  Durata minima     : {0:D2}:{1:D2}:{2:D2}" -f [int]($minSeconds/3600),[int](($minSeconds%3600)/60),[int]($minSeconds%60))
    Write-Host ("  Durata massima    : {0:D2}:{1:D2}:{2:D2}" -f [int]($maxSeconds/3600),[int](($maxSeconds%3600)/60),[int]($maxSeconds%60))
}
Write-Host ("  Durata totale (wall clock): {0:D2}:{1:D2}:{2:D2}" -f $globalDuration.Hours, $globalDuration.Minutes, $globalDuration.Seconds)

# ── Riepilogo per Environment ──
Write-Host "`n----------------------------------------------------------"
Write-Host "  RIEPILOGO PER ENVIRONMENT"
Write-Host "----------------------------------------------------------"
$allRuns | Group-Object Environment | Sort-Object Name | ForEach-Object {
    $envRuns      = $_.Group
    $envCompleted = $envRuns | Where-Object { $_.State -eq "completed" }
    $envSucceeded = $envCompleted | Where-Object { $_.Result -eq "succeeded" }
    $envFailed    = $envCompleted | Where-Object { $_.Result -ne "succeeded" }
    Write-Host ("  [{0,-6}]  Totale: {1,4}  |  Succeeded: {2,4}  |  Failed: {3,4}  |  Altri: {4,4}" -f `
        $_.Name, $envRuns.Count, $envSucceeded.Count, $envFailed.Count, ($envRuns.Count - $envCompleted.Count))
}

# ── Riepilogo per Project ──
Write-Host "`n----------------------------------------------------------"
Write-Host "  RIEPILOGO PER PROJECT"
Write-Host "----------------------------------------------------------"
$allRuns | Group-Object Project | Sort-Object Name | ForEach-Object {
    $prjRuns      = $_.Group
    $prjCompleted = $prjRuns | Where-Object { $_.State -eq "completed" }
    $prjSucceeded = $prjCompleted | Where-Object { $_.Result -eq "succeeded" }
    $prjFailed    = $prjCompleted | Where-Object { $_.Result -ne "succeeded" }
    Write-Host ("  {0,-40}  Totale: {1,3}  |  Succeeded: {2,3}  |  Failed: {3,3}" -f `
        $_.Name, $prjRuns.Count, $prjSucceeded.Count, $prjFailed.Count)
}

# ── Dettaglio run fallite ──
$allFailed = $allRuns | Where-Object { $_.Result -ne "succeeded" -and $_.State -in @("completed","failedToStart","timeout") }
if ($allFailed.Count -gt 0) {
    Write-Host "`n----------------------------------------------------------"
    Write-Host "  DETTAGLIO RUN NON SUCCEEDED"
    Write-Host "----------------------------------------------------------"
    $allFailed | Sort-Object Environment, Project | Format-Table -AutoSize -Property `
        @{L="Project";    E={$_.Project}},
        @{L="PipelineId"; E={$_.PipelineId}},
        @{L="Workload";   E={$_.Workload}},
        @{L="Env";        E={$_.Environment}},
        @{L="RunId";      E={$_.RunId}},
        @{L="State";      E={$_.State}},
        @{L="Result";     E={$_.Result}},
        @{L="Error";      E={$_.Error}}
} else {
    Write-Host "`n  Tutte le run sono succeeded."
}

Write-Host "----------------------------------------------------------`n"

# ── Report separato WORKLOAD ──
Write-Host "`n=========================================================="
Write-Host "  REPORT WORKLOAD"
Write-Host "==========================================================`n"

$allWorkloadRuns | Sort-Object Environment, Workload | Format-Table -AutoSize -Property `
    @{L="Project";    E={$_.Project}},
    @{L="PipelineId"; E={$_.PipelineId}},
    @{L="Workload";   E={$_.Workload}},
    @{L="Env";        E={$_.Environment}},
    @{L="RunId";      E={$_.RunId}},
    @{L="State";      E={$_.State}},
    @{L="Result";     E={$_.Result}},
    @{L="Duration";   E={if($_.Duration){"{0:D2}:{1:D2}:{2:D2}" -f $_.Duration.Hours,$_.Duration.Minutes,$_.Duration.Seconds}else{""}}}

$wlCompleted = $allWorkloadRuns | Where-Object { $_.State -eq "completed" }
$wlSucceeded = $wlCompleted | Where-Object { $_.Result -eq "succeeded" }
$wlFailed    = $wlCompleted | Where-Object { $_.Result -ne "succeeded" }

Write-Host "----------------------------------------------------------"
Write-Host "  Totale workload run  : $($allWorkloadRuns.Count)"
Write-Host "  Succeeded            : $($wlSucceeded.Count)"
Write-Host "  Failed/Other         : $($wlFailed.Count)"

$wlFailedDetail = $allWorkloadRuns | Where-Object { $_.Result -ne "succeeded" -and $_.State -in @("completed","failedToStart","timeout") }
if ($wlFailedDetail.Count -gt 0) {
    Write-Host "`n  WORKLOAD NON SUCCEEDED:"
    $wlFailedDetail | Sort-Object Environment, Workload | Format-Table -AutoSize -Property `
        @{L="Workload"; E={$_.Workload}},
        @{L="Env";      E={$_.Environment}},
        @{L="RunId";    E={$_.RunId}},
        @{L="State";    E={$_.State}},
        @{L="Result";   E={$_.Result}},
        @{L="Error";    E={$_.Error}}
} else {
    Write-Host "  Tutti i workload sono succeeded."
}
Write-Host "----------------------------------------------------------`n"
