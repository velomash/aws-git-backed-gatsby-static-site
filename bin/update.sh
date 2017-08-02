#!/bin/bash

echo "Building and uploading lambda functions..."

SYNC_STATIC_SITE_TO_S3_VERSION=$(./SyncStaticSiteToS3/build.sh)
GENERATE_GATSBY_STATIC_SITE_VERSION=$(./GenerateGatsbyStaticSite/build.sh)

echo "Success!"
echo ""

aws cloudformation update-stack \
  --stack-name=$STACK_NAME \
  --template-body=file://cloudformation.yaml \
  --parameters=file://$STACK_NAME-parameters.json \
  --capabilities CAPABILITY_IAM

  # TODO: add version parameters of other functions here
  # ParameterKey=FooFunctionVersion,ParameterValue=$FOO_FUNCTION_VERSION

echo "Updating the $STACK_NAME stack..."

aws cloudformation wait stack-update-complete --stack-name $STACK_NAME
