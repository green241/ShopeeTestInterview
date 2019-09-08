#! /bin/bash

## Get Parameter
ECS_CLUSTER=$1
ECS_SERVICE=$2
EXPECTED_CAPACITY=$3

# Function 
Function Error_Log{
	echo $1
	echo "Could not continue the process. Exiting ... "
	exit
}

Function Debug_Log{
	echo "$1"
}


# Main
Debug_Log "Making sure that jq is installed"
JQ_CHECK=$(jq 2>&1)
if [[ "$JQ_CHECK" == *'not  found'* ]]; then
	Error_Log "Package 'jq' is not found. Please install jq first based on you OS Distribution. Thanks"
fi

Debug_Log "Describing ECS Service tag"
ECS_SERVICE_DETAIL=`aws ecs describe-services --cluster $ECS_CLUSTER --services $ECS_SERVICE --include "TAGS" 2>&1`
if [[ "${ECS_SERVICE_DETAIL,,}" == *"error"* || "${ECS_SERVICE_DETAIL,,}" == *"failed"* || "$(echo $ECS_SERVICE_DETAIL | jq)" == *"invalid"* ]]; then
	Error_Log "Error describe ECS Service. Response: ${ECS_SERVICE_DETAIL}"
fi

ECS_SERVICE_TAG=$(aws ecs list-tags-for-resource --resource-arn $(echo $ECS_SERVICE_DETAIL | jq -r '.services[].serviceArn')2>&1) 
ECS_INITIAL_COUNT=$(echo $ECS_SERVICE_TAG | jq 'select(.Name=="INITIAL_COUNT") | .Value')
if [[ "${ECS_INITIAL_COUNT,,}" == *"invalid"* ]]; then
	Error_Log "Error getting ECS Service Tag. Response: ${ECS_SERVICE_DETAIL}"
fi
Debug_Log "Service Initial Count is $ECS_INITIAL_COUNT"

DESIRED_COUNT=$((ECS_INITIAL_COUNT*EXPECTED_CAPACITY))
Debug_Log "Desired count is $DESIRED_COUNT"
UPDATE_ECS_SERVICE=$(aws ecs update-service --cluster $ECS_CLUSTER --services $ECS_SERVICE --desired-count $DESIRED_COUNT 2>&1)
if [[ "${ECS_INITIAL_COUNT,,}" == *"invalid"* ]]; then
	Error_Log "Error getting ECS Service Tag. Response: ${ECS_SERVICE_DETAIL}"
fi
Debug_Log "Process Finished"


