#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Cloudformation stack name>"
    exit 1
fi

if [[ $1 == *.yaml ]]; then
    STACK_NAME=$(echo $1 | sed 's|.yaml$||')
    FILE_NAME=$1
else
    STACK_NAME=$1
    FILE_NAME=$STACK_NAME.yaml
fi

STACK_NAME=$(basename $STACK_NAME)
REGION_NAME=$(aws cloudformation list-exports --query 'Exports[?Name==`app-01-vpc-stack:vpc-region`].Value' --output text)

aws cloudformation update-stack \
  --stack-name ${STACK_NAME} \
  --region $REGION_NAME \
  --template-body file://${FILE_NAME}
