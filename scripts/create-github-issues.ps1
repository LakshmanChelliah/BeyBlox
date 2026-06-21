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
foreach ($ms in $data.milestones) {
    $created = gh api repos/{owner}/{repo}/milestones -f title=$ms.title -f description=$ms.description -f state=open 2>$null
    if ($LASTEXITCODE -ne 0) {
        $existing = gh api repos/{owner}/{repo}/milestones --jq ".[] | select(.title==`"$($ms.title)`") | .number" 2>$null
        if ($existing) { $milestoneMap[$ms.title] = [int]$existing }
    } else {
        $num = ($created | ConvertFrom-Json).number
        $milestoneMap[$ms.title] = $num
        Write-Host "  + $($ms.title) (#$num)"
    }
}

# Refresh milestone map from API
$allMs = gh api repos/{owner}/{repo}/milestones --jq ".[] | {title, number}" | ConvertFrom-Json
foreach ($m in $allMs) { $milestoneMap[$m.title] = $m.number }

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
