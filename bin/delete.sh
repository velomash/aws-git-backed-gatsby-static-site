#!/bin/bash

aws cloudformation delete-stack \
  --stack-name=$STACK_NAME

echo "Deleting the $STACK_NAME stack..."

aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME
