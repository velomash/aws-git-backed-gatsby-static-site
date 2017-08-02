#!/bin/bash

echo "Building and uploading lambda functions..."

SYNC_STATIC_SITE_TO_S3_VERSION=$(./SyncStaticSiteToS3/build.sh)

echo "Success!"
echo ""

aws cloudformation create-stack \
  --stack-name=$STACK_NAME \
  --template-body=file://cloudformation.yaml \
  --capabilities CAPABILITY_IAM \
  --parameters \
    ParameterKey=DomainName,ParameterValue=$DOMAIN_NAME \
    ParameterKey=NotificationEmail,ParameterValue=$NOTIFICATION_EMAIL \
    ParameterKey=GitHubOwner,ParameterValue=$GITHUB_OWNER \
    ParameterKey=GitHubRepo,ParameterValue=$GITHUB_REPO \
    ParameterKey=GitHubBranch,ParameterValue=$GITHUB_BRANCH \
    ParameterKey=GitHubToken,ParameterValue=$GITHUB_TOKEN \
    ParameterKey=LambdaBucket,ParameterValue=lambdas.$DOMAIN_NAME \
    ParameterKey=SyncLambdaFunctionS3Key,ParameterValue=SyncStaticSiteToS3-${SYNC_STATIC_SITE_TO_S3_VERSION-latest}.zip

echo "Creating the $STACK_NAME stack..."

aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
