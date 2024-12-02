# Set your Azure DevOps organization and PAT
$Organization = ""
$PAT = ""

# Encode PAT for authorization
$Base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($PAT)"))

# Initialize an array to store results
$Results = @()
# Function to send API requests
function Invoke-AzDevOpsRestApi {
    param (
        [string]$Uri
    )
    $Headers = @{
        Authorization = "Basic $Base64AuthInfo"
    }
    Invoke-RestMethod -Uri $Uri -Headers $Headers -Method Get -ContentType "application/json"
}

# Get all projects
$ProjectsUri = "https://dev.azure.com/$Organization/_apis/projects?api-version=7.1-preview.4"
$Projects = Invoke-AzDevOpsRestApi -Uri $ProjectsUri

foreach ($Project in $Projects.value) {
    Write-Host "Checking Project: $($Project.name)"

    # Get all environments associated with the project
    $EnvironmentsUri = "https://dev.azure.com/$Organization/$($Project.name)/_apis/distributedtask/environments?api-version=7.1-preview.1"
    $Environments = Invoke-AzDevOpsRestApi -Uri $EnvironmentsUri

    foreach ($Environment in $Environments.value) {
        Write-Host "   - Checking Environment: $($Environment.name)"

        # Get the environment configuration (approvals and checks)
        $ConfigUri = "https://dev.azure.com/$Organization/$($Project.name)/_apis/pipelines/checks/configurations?resourceType=environment&resourceId=$($Environment.id)&$expand=settings&api-version=7.1-preview.1"
        
        try {
            $ConfigResponse = Invoke-AzDevOpsRestApi -Uri $ConfigUri
            
            # Check if any configurations are found
            if ($ConfigResponse.count -gt 0) {
                $ConfigType = $ConfigResponse.value[0].type.name
                $ConfigFound = "Y - $ConfigType"
            } else {
                $ConfigFound = "N"
            }
        } catch {
            Write-Warning "Could not retrieve configuration details for environment $($Environment.name)"
            $ConfigFound = "Error"
        }

        # Add the data to the results array
        $Results += [PSCustomObject]@{
            Project                  = $Project.name
            Environment              = $Environment.name
            "Approval policy configured (Y/N)" = if ($ConfigFound -eq "N") { "N" } else { "Y" }
            "Configuration type"     = $ConfigFound
        }
    }
}

# Export results to a CSV file
$OutputFile = "AzureDevOps_Environments_Approvals_Checks_Report.csv"
$Results | Export-Csv -Path $OutputFile -NoTypeInformation -Encoding UTF8

Write-Host "Report saved to $OutputFile"
