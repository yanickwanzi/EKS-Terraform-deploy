#!/bin/bash
response="$(aws eks list-clusters --region us-west-2 --output text | grep -i dominion-cluster 2>&1)" 
if [[ $? -eq 0 ]]; then
    echo "Deploying observerbility addon in dominion cluster"
    --role-name node-group-01-eks-node-group-20240703121357377000000002 \
    --policy-arn arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy 
    aws eks create-addon --cluster-name dominion-cluster --addon-name amazon-cloudwatch-observability

else
    echo "Error: Dominion-cluster does not exist"
fi