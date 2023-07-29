# Function to check if a directory is a Maven project
function IsMavenProject {
    Test-Path "pom.xml" -PathType Leaf
}

# Function to check if a directory is a Gradle project
function IsGradleProject {
    Test-Path "build.gradle" -PathType Leaf
}

# Function to search and replace string in pom.xml file
function ReplaceStringInPom {
    param(
        [string]$searchString,
        [string]$replaceString
    )
    (Get-Content "pom.xml") | ForEach-Object { $_ -replace $searchString, $replaceString } | Set-Content "pom.xml"
}

# Function to create a branch, commit changes, and push
function CreateBranchCommitPush {
    param(
        [string]$branchName,
        [string]$commitMessage
    )
    git checkout -b $branchName
    git add .
    git commit -m $commitMessage
    git push origin $branchName
}

# Main script starts here

if ($args.Count -eq 0) {
    Write-Host "Usage: PowerShellScript.ps1 <repo> or PowerShellScript.ps1 -csv <path_to_csv>"
    exit 1
}

if ($args[0] -eq "-csv") {
    $csvPath = $args[1]
    $repos = Import-Csv -Path $csvPath | Select-Object -ExpandProperty repos
} else {
    $repos = $args
}

Write-Host "Enter the string to search for in pom.xml:"
$searchString = Read-Host

Write-Host "Enter the string to replace it with:"
$replaceString = Read-Host

foreach ($repo in $repos) {
    # Clone the repo
    git clone $repo

    # Get the repo name
    $repoName = [System.IO.Path]::GetFileNameWithoutExtension($repo)

    # Move into the repo directory
    Set-Location $repoName

    # Check if it's a Maven project
    if (IsMavenProject) {
        Write-Host "Maven project found: $repoName"

        # Perform search and replace in pom.xml
        ReplaceStringInPom $searchString $replaceString

        # Commit changes and push to a branch
        CreateBranchCommitPush "update_$searchString" "Updated $searchString to $replaceString"
    } elseif (IsGradleProject) {
        Write-Host "Gradle project found: $repoName"
        # Add code here for Gradle-specific actions (if needed)
    } else {
        Write-Host "Not a Maven or Gradle project: $repoName"
    }

    # Move back to the original directory for the next iteration
    Set-Location ..
}
