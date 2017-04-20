#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Cloudformation stack name>"
    exit 1
fi

if [[ $1 == *.yaml ]]; then
    STACK_NAME=$(echo $1 | sed 's|.yaml$||')
    TEMPLATE_NAME=$1
else
    STACK_NAME=$1
    TEMPLATE_NAME=$STACK_NAME.yaml
fi

STACK_NAME=$(basename $STACK_NAME)
REGION_NAME=$(aws cloudformation list-exports --query 'Exports[?Name==`app-01-vpc-stack:vpc-region`].Value' --output text)
FINAL_STACK_NAME="$USER-$STACK_NAME-$(date +"%Y%m%d%H%M%S")"
echo "FINAL_STACK_NAME: $FINAL_STACK_NAME"

aws cloudformation deploy \
  --capabilities CAPABILITY_NAMED_IAM \
  --region $REGION_NAME \
  --stack-name $FINAL_STACK_NAME \
  --template-file $TEMPLATE_NAME


#   --tags Key=Owner,Value=$USER Key=Disposition,Value=DELETE \
