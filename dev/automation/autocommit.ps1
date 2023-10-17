<#

Automatically commit several files and add "fixup! " if commit with same name already exist

#>

# List of files that changing with mods
$files = @(
    "config/BlockDrops/modVersions.txt",
    "minecraftinstance.json",
    "MODS.md"
)

Write-Host "-- Entering auto commit --"
if ((git status --porcelain | Where-Object { $_ -match '^[MADRC] ' }).Count -eq 0) {
    Write-Host " No staged changes"

    $modifiedFiles = git status --porcelain $files | Where-Object { $_-match '^\s*M ' } | ForEach-Object { $_.Trim().Split(' ')[-1] }

    if ($modifiedFiles.Count -gt 0) {
        Write-Host " have modified files"

        $commitMessage = "chore(mods): "+[char]::ConvertFromUtf32(0x1F535)+" Mods updates"
        $localCommits = git log --branches --not --remotes --pretty=format:"%h %s"
        foreach ($commit in $localCommits) {
            if ($commit.Contains(" Mods updates") -and $commit.Contains("chore(mods): ")) {
                $commitMessage = "fixup! " + $commitMessage
                break
            }
        }

        Write-Host " Commit Message would be: "+$commitMessage

        git add $modifiedFiles
        git commit -m $commitMessage
    }
} else {
    Write-Host "[ERROR] Have staged changes"
}