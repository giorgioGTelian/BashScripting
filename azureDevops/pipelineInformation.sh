#!/bin/bash

#### Variable Initialization ####

# Azure DevOps PAT Token
AzureDevOpsPAT=""

# Azure DevOps Org Name
OrganizationName="OrgName"

# Base64 encoded PAT Token for Azure DevOps
AzureDevOpsAuth=$(echo -n ":$AzureDevOpsPAT" | base64)

# Authentication header for GET requests
AzureDevOpsAuthHeader="Authorization: Basic $AzureDevOpsAuth"

# Authentication header in JSON format for POST requests
JSONAzureDevOpsAuthHeader=("Authorization: Basic $AzureDevOpsAuth" "Content-Type: application/json")

# Base URI
UriOrga="https://dev.azure.com/$OrganizationName/"

# Empty arrays to collect data for CSV export
exportDataCompletedFailed=()
exportDataCompletedSucceded=()

# Project names to analyze
projectNames=("one" "two" "poke")

#### Function to export data ####

add_to_export_data() {
    pipelineName=$1
    runId=$2
    runState=$3
    runResult=$4
    runName=$5
    action=$6
    environment=$7
    timelineRecordsExport=$8
    changesPlan=$9
    noChangesPlan=${10}

    # Export failed pipelines
    if [ "$runResult" == "failed" ]; then
        exportDataCompletedFailed+=("Pipeline Name: $pipelineName, Run ID: $runId, Run State: $runState, Run Result: $runResult, Run Name: $runName, Action: $action, Environment: $environment, Timeline Records: $timelineRecordsExport, Terraform Plan Changes: $changesPlan, Terraform Plan No Changes: $noChangesPlan")
        echo "${exportDataCompletedFailed[@]}" > "Pipelines_failed_export_$(date +%Y%m%d).csv"
    fi

    # Export succeeded pipelines
    if [ "$runResult" == "succeeded" ]; then
        exportDataCompletedSucceded+=("Pipeline Name: $pipelineName, Run ID: $runId, Run State: $runState, Run Result: $runResult, Run Name: $runName, Action: $action, Environment: $environment, Timeline Records: $timelineRecordsExport, Terraform Plan Changes: $changesPlan, Terraform Plan No Changes: $noChangesPlan")
        echo "${exportDataCompletedSucceded[@]}" > "Pipelines_succeded_export_$(date +%Y%m%d).csv"
    fi
}

#### Function to process Terraform Records ####

process_terraform_record() {
    local recordName=$1
    local record=$2
    local authHeader=$3

    if [ "$recordName" == "$record" ]; then
        terraformResult=$(echo "$record" | jq -r '.result')
        terraformLogUrl=$(echo "$record" | jq -r '.log.url')
        terraformOutput=$(curl -s -H "$authHeader" "$terraformLogUrl")
        latestRunDate=$(date -d "$(echo "$latestRun" | jq -r '.createdDate')" '+%Y-%m-%d')

        if [ "$environment" == "pro" ]; then
            if [ "$recordName" == "terraform init" ]; then
                echo "Pipeline name: $pipelineName"
                echo "Action: $action"
                echo "Environment: $environment"
                echo "$recordName results: $terraformResult"
            fi

            if [ "$recordName" == "terraform plan" ]; then
                echo "$recordName results: $terraformResult"
                if [ "$terraformResult" == "succeeded" ]; then
                    changesPlan=$(echo "$terraformOutput" | grep -oP "Plan:.*")
                    noChangesPlan=$(echo "$terraformOutput" | grep -oP "No changes.*")
                    echo "$changesPlan, $noChangesPlan"
                    add_to_export_data "$pipelineName" "$runId" "$runState" "$runResult" "$runName" "$action" "$environment" "$timelineRecordsExport" "$changesPlan" "$noChangesPlan"
                fi
            fi
        fi
    fi
}

#### Fetch Projects ####
uriProjects="${UriOrga}_apis/projects?api-version=7.1"
projects=$(curl -s -H "$AzureDevOpsAuthHeader" "$uriProjects" | jq -r '.value[] | select(.name | inside("'"${projectNames[*]}"'"))')

#### Iterate over the filtered projects ####
for project in $projects; do
    projectName=$(echo "$project" | jq -r '.name')
    echo "------------------ $projectName ------------------"

    # Construct the URI for pipelines
    uriPipelines="${UriOrga}${projectName}/_apis/pipelines?api-version=7.1-preview.1"
    pipelines=$(curl -s -H "$AzureDevOpsAuthHeader" "$uriPipelines" | jq -r '.value[]')

    #### Iterate over each pipeline ####
    for pipeline in $pipelines; do
        pipelineId=$(echo "$pipeline" | jq -r '.id')
        pipelineName=$(echo "$pipeline" | jq -r '.name')

        # Get pipeline runs
        uriPipelineRuns="${UriOrga}${projectName}/_apis/pipelines/${pipelineId}/runs?api-version=7.1-preview.1"
        pipelineRuns=$(curl -s -H "$AzureDevOpsAuthHeader" "$uriPipelineRuns" | jq -r '.value[0]')

        if [ -n "$pipelineRuns" ]; then
            latestRun=$(echo "$pipelineRuns" | jq -r '.[0]')
            status=$(echo "$latestRun" | jq -r '.state')
            runId=$(echo "$latestRun" | jq -r '.id')
            runState=$(echo "$latestRun" | jq -r '.state')
            runResult=$(echo "$latestRun" | jq -r '.result')

            uriGetRun="${UriOrga}${projectName}/_apis/pipelines/${pipelineId}/runs/${runId}?api-version=7.1-preview.1"
            getRunResponse=$(curl -s -H "$AzureDevOpsAuthHeader" "$uriGetRun")

            action=$(echo "$getRunResponse" | jq -r '.templateParameters.Action')
            environment=$(echo "$getRunResponse" | jq -r '.templateParameters.Environment')

            uriTimeline="${UriOrga}${projectName}/_apis/build/builds/${runId}/timeline?api-version=7.1"
            timeline=$(curl -s -H "$AzureDevOpsAuthHeader" "$uriTimeline")
            timelineRecordsExport=$(echo "$timeline" | jq -r '.records[] | select(.name | contains("terraform"))')

            #### Iterate over timeline records ####
            for record in $timelineRecordsExport; do
                process_terraform_record "terraform init" "$record" "$AzureDevOpsAuthHeader"
                process_terraform_record "terraform plan" "$record" "$AzureDevOpsAuthHeader"
            done

            # Export data
            add_to_export_data "$pipelineName" "$runId" "$runState" "$runResult" "$runName" "$action" "$environment" "$timelineRecordsExport"
        else
            echo "No pipeline runs found for project $projectName"
        fi
    done
done
