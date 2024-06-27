#!/bin/bash
aws eks list-clusters --region us-west-2 --output text 2>&1
if  [ $? != 0 ]
then
    echo "dominion-cluster does not exist"
else
    echo "updating cluster kubeconfig file "
    aws eks --region us-west-2 update-kubeconfig --name dominion-cluster && export KUBE_CONFIG_PATH=~/.kube/conf
fi