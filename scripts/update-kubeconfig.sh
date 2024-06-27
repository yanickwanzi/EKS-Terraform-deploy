#!/bin/bash
if aws eks list-clusters --region us-west-2 --output text 2>&1 ; then
else
  e=$?        # return code from if
  if [ "${e}" != 0 ]; then
    echo "dominion-cluster does not exist"
  elif [ "${e}" == 0]; then
    echo "updating cluster kubeconfig file"
    aws eks --region us-west-2 update-kubeconfig --name dominion-cluster && export KUBE_CONFIG_PATH=~/.kube/conf
  fi
fi