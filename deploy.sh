#!/usr/bin/env bash
# This file pushes the current committed version of the 
# container to the gigster elastic container registry (ecr)
# so it can be used on kubernetes
#
# This file should be usable in its current form
#
# Pre-reqs:
#   Variables $AWS_DEFAULT_REGION, $AWS_ACCOUNT_ID must be set
#   in your circleci settings, which is done through the admin
#   console for this script to run properly 
#
# Note:
#  The values of $CIRCLE_PROJECT_REPONAME and $CIRCLE_SHA1 are
#  managed by circleci, and you do not have to set them
#  explicitly

# more bash-friendly output for jq
JQ="jq --raw-output --exit-status"

k8s_config(){
    envsubst < k8s/kubconfig.yml.template > k8s/kubconfig.yml
}

k8s_deploy(){
   kubectl rolling-update $CIRCLE_PROJECT_REPONAME --image=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$CIRCLE_PROJECT_REPONAME:$CIRCLE_BUILD_NUM
}

configure_aws_cli(){
    aws --version
    aws configure set default.region $AWS_DEFAULT_REGION
    aws configure set default.output json
}

push_ecr_image(){
    eval $(aws ecr get-login --region $AWS_DEFAULT_REGION)
    docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$CIRCLE_PROJECT_REPONAME:$CIRCLE_BUILD_NUM
}

configure_aws_cli
push_ecr_image
k8s_config
k8s_deploy

