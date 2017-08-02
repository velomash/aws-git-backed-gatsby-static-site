#!/bin/bash

echo "Building and uploading lambda functions..."

./GenerateGatsbyStaticSite/build.sh
./SyncStaticSiteToS3/build.sh

echo "Success!"
echo ""

# TODO: add other functions here

aws cloudformation create-stack \
  --stack-name=$STACK_NAME \
  --template-body=file://cloudformation.yaml \
  --capabilities CAPABILITY_IAM \
  --parameters \
    ParameterKey=S3BucketName,ParameterValue=$S3_BUCKET_NAME \

echo "Creating the $STACK_NAME stack..."

aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
