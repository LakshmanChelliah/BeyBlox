# Creates GitHub labels, milestones, and issues from scripts/github-issues.json.
# Run once after pushing the repo:  .\scripts\create-github-issues.ps1
# Requires: gh CLI authenticated, run from repo root.

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path $PSScriptRoot -Parent
Set-Location $RepoRoot

$jsonPath = Join-Path $PSScriptRoot "github-issues.json"
$data = Get-Content $jsonPath -Raw -Encoding UTF8 | ConvertFrom-Json

Write-Host "Creating labels..."
foreach ($label in $data.labels) {
    $existing = gh label list --json name --jq ".[].name" 2>$null
    if ($existing -notcontains $label.name) {
        gh label create $label.name --color $label.color --description $label.description 2>$null
        Write-Host "  + $($label.name)"
    }
}

Write-Host "Creating milestones..."
$milestoneMap = @{}
$allMilestones = gh api "repos/LakshmanChelliah/BeyBlox/milestones?state=all" | ConvertFrom-Json
foreach ($ms in $data.milestones) {
    $title = $ms.title
    $found = $allMilestones | Where-Object { $_.title -eq $title } | Select-Object -First 1
    if ($found) {
        $milestoneMap[$title] = [int]$found.number
        Write-Host "  = $title (#$($found.number))"
    } else {
        $payloadFile = [System.IO.Path]::GetTempFileName()
        try {
            $payload = @{ title = $title; description = $ms.description; state = "open" } | ConvertTo-Json -Compress
            [System.IO.File]::WriteAllText($payloadFile, $payload, [System.Text.UTF8Encoding]::new($false))
            $result = gh api "repos/LakshmanChelliah/BeyBlox/milestones" --method POST --input $payloadFile
            $num = ($result | ConvertFrom-Json).number
            $milestoneMap[$title] = $num
            $allMilestones += ($result | ConvertFrom-Json)
            Write-Host "  + $title (#$num)"
        } finally {
            Remove-Item $payloadFile -Force -ErrorAction SilentlyContinue
        }
    }
}

Write-Host "Creating issues..."
$count = 0
foreach ($issue in $data.issues) {
    $bodyFile = [System.IO.Path]::GetTempFileName()
    try {
        [System.IO.File]::WriteAllText($bodyFile, $issue.body, [System.Text.UTF8Encoding]::new($false))
        $labelArgs = @()
        foreach ($l in $issue.labels) { $labelArgs += "--label"; $labelArgs += $l }
        $msNum = $milestoneMap[$issue.milestone]
        $msArg = if ($msNum) { @("--milestone", $issue.milestone) } else { @() }
        & gh issue create --title $issue.title --body-file $bodyFile @labelArgs @msArg
        if ($LASTEXITCODE -eq 0) {
            $count++
            Write-Host "  [$count] $($issue.title)"
        }
    } finally {
        Remove-Item $bodyFile -Force -ErrorAction SilentlyContinue
    }
    Start-Sleep -Milliseconds 300
}

Write-Host "Done. Created $count issues."
