# Verifica e importazione dei moduli Azure necessari
try {
    $requiredModules = @('Az.Accounts', 'Az.Resources')
    
    foreach ($module in $requiredModules) {
        if (-not (Get-Module -ListAvailable -Name $module)) {
            Write-Host "Installing module $module..."
            Install-Module -Name $module -Scope CurrentUser -Force -AllowClobber
        }
        
        Write-Host "Importing module $module..."
        Import-Module $module -Force
    }
}
catch {
    Write-Host "Errore durante il caricamento dei moduli Azure: $_"
    exit
}

# Connessione ad Azure
try {
    Write-Host "Connecting to Azure..."
    Connect-AzAccount -ErrorAction Stop
    Write-Host "Successfully connected to Azure."
}
catch {
    Write-Host "Errore durante la connessione ad Azure: $_"
    exit
}

# Configurazione iniziale
$OrganizationName = "organizationname"
$apiVersion = "7.1-preview.4"

# PAT
$AzureDevOpsPAT = ""

# Header di autenticazione per Azure DevOps
$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

# URI di base
$UriOrga = "https://dev.azure.com/$($OrganizationName)/"

# Ottenere i progetti
$uriProjects = $UriOrga + "_apis/projects?api-version=5.1"
$Projects = Invoke-RestMethod -Uri $uriProjects -Method get -Headers $AzureDevOpsAuthenicationHeader 

# lista vuota per i dati CSV
$exportData = @()

####################################################################################################################

# GET 
# get all the service principal
$scUrl = "https://vssps.dev.azure.com/$OrganizationName/_apis/graph/serviceprincipals?api-version=7.1-preview.1"
$servicePrincipals = Invoke-RestMethod -Uri $scUrl -Method Get -Headers $AzureDevOpsAuthenicationHeader
Write-Host "===================== $servicePrincipals  ================="
foreach ($servicePrincipal in $servicePrincipals.value) {
    $servicePrincipalName = $servicePrincipal.displayName
    Write-Host "===================== $servicePrincipalName ================="
}

####################################################################################################################

# Ottenere le connessioni di servizio per ogni progetto
foreach ($project in $Projects.value) {
    $projectName = $project.name
    Write-Host "=========================== Processing project: $projectName"
    
    try {
        # API per ottenere le service connections
        $serviceConnectionsUrl = "$UriOrga$projectName/_apis/serviceendpoint/endpoints?api-version=6.0-preview.4"
        $serviceConnections = Invoke-RestMethod -Uri $serviceConnectionsUrl -Method Get -Headers $AzureDevOpsAuthenicationHeader
        
        foreach ($connection in $serviceConnections.value) {
            $connectionName = $connection.name
			$connectionType = $connection.type
            Write-Host "Found service connection: $connectionName"
			Write-Host "Found service connection: $connectionType"
            
            # Verifica se è una connessione di tipo Azure (Service Principal)
            if ($connection.type -eq "azurerm" -and $connection.authorization -and $connection.authorization.parameters) {
                $clientId = $connection.authorization.parameters.serviceprincipalid
                
                if ($clientId) {
                    Write-Host "Azure Service Principal Client ID: $clientId"
                    
                    try {
                        $SPN = Get-AzADApplication -Filter "appId eq '$clientId'"
                        if ($SPN) {
                            Write-Host "Azure AD Application found:"
                            Write-Host "DisplayName: $($SPN.DisplayName)"
                            Write-Host "AppId: $($SPN.AppId)"
                            Write-Host "ObjectId: $($SPN.ObjectId)"
							    # Aggiungi i dati all'array di export
								$exportData += [PSCustomObject]@{
									"DataReport" = $reportDate
									"Organization" = $OrganizationName
									"Project" = $projectName
									"ServiceConnection" = $connectionName
									"ServiceConnectionType" = $sc.type
									"Azure Service Principal Client ID " = $clientId
									"Azure AD application name" = $($SPN.DisplayName)
									"ObjectID" = $($SPN.ObjectId)
								}
                        } else {
                            Write-Host "No Azure AD Application found for client ID: $clientId"
                        }
                    } catch {
                        Write-Host "Error retrieving Azure AD Application for client ID $clientId : $_"
                    }
                }
            }
        }
    } catch {
        Write-Host "Error retrieving service connections for project $projectName : $_"
    }
}
# Esporta i dati in CSV
$exportData | Export-Csv -Path "export_service_connectionv2.csv" -NoTypeInformation -Delimiter ";" -Encoding UTF8

# Riepilogo finale
Write-Host "===================================================="
Write-Host "Riepilogo finale" -ForegroundColor Magenta
Write-Host "Organizzazione: $OrganizationName"
Write-Host "Progetti analizzati: $($projects.Count)"
Write-Host "Service connections totali trovate: $totalScCount"
Write-Host "Report CSV generato" -ForegroundColor Green
