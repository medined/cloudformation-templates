#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Cloudformation stack name>"
    exit 1
fi

if [[ $1 == *.yaml ]]; then
    STACK_NAME=$(echo $1 | sed 's|.yaml$||')
else
    STACK_NAME=$1
fi

STACK_NAME=$(basename $STACK_NAME)

aws cloudformation delete-stack \
    --stack-name ${STACK_NAME}
