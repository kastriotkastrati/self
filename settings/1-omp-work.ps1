oh-my-posh init pwsh | Invoke-Expression
& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\pure.omp.json" --print) -join "`n"))
