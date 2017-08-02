#!/bin/bash

{
  rm SyncStaticSiteToS3.zip
  cd SyncStaticSiteToS3; zip -r ../SyncStaticSiteToS3.zip *; cd ..;
} &> /dev/null

Version=$(md5sum -b SyncStaticSiteToS3.zip | awk '{print $1}')

{
  aws s3 mb s3://lambdas.$DOMAIN_NAME
  aws s3 cp SyncStaticSiteToS3.zip s3://lambdas.$DOMAIN_NAME/SyncStaticSiteToS3-$Version.zip
  aws s3 cp SyncStaticSiteToS3.zip s3://lambdas.$DOMAIN_NAME/SyncStaticSiteToS3-latest.zip
  rm SyncStaticSiteToS3.zip
} &> /dev/null

echo $Version
