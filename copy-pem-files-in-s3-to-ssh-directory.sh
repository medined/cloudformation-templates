#!/bin/bash

# Some organizations use more than one PEM file to SSH into EC2 instances. If
# SSH keys are rotated you might have more than one PEM file to manage. One
# approach stores the PEM files into an S3 bucket that is associated with the
# VPC. This VPC bucket is created by the vpc-stack template.

# This script copies PEM files from an S3 bucket into the local .ssh directory
# to enable SSH into EC2 instances.

aws s3 cp --recursive s3://vpc-storage/ ~/.ssh > /dev/null
chmod 600 ~/.ssh/*.pem
echo "=== PEM FILES ==="
for f in $(ls -1 ~/.ssh/*.pem); do basename $f; done
