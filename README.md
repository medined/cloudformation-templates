# CloudFormation Templates

## Introduction

This set of templates work together to provide an ecosystem inside AWS that
accelerates working with AWS services.

The stacks are number so you'll know the order to create them.

* app-01-vpc-stack - one VPC, two public subnets, two private subnets and a
whole lot of other stuff. On 2017-04-11, there were 35 resources created by
the stack.

* app-02-role-readonly-codecommit-ecr-s3-stack - This stack provides an
instance role that can be used with EC2 instances that need read-only access
to CodeCommit, ECR, or S3. This is the type of access needed to deploy
applications (i.e., not for development)

* app-03-security-groups-stack - This stack provides single-purpose security
groups so you can use composition to aid clarity.

* app-04-hosted-zone-stack - This stack creates a hosted zone that can
provide DNS host names for your servers.

## scripts

All scripts are located in the `scripts` directory to make them easy to find.

## NOTES

* If your template creates a S3 folder and objects are stored in it, then then
stack will not delete automatically.

## Links

* https://aws.amazon.com/answers/infrastructure-management/ec2-scheduler/
* http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-custom-resources-lambda.html
* https://blog.jayway.com/2015/07/04/extending-cloudformation-with-lambda-backed-custom-resources/

## What is the Latest Centos AMI?

As of 2017 Apr 11, the current AMI is ami-6d1c2007. You can learn if a new AMI
is available using the following command.

```
aws ec2 describe-images \
 --region us-east-1 \
 --owners aws-marketplace \
 --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce Name=root-device-type,Values=ebs \
 --output text | jq --raw-input '.Images[0].ImageId'
```

## Checking USERDATA

When you send USERDATA into an EC2 instance it is useful to know where the
scripts are located.

Location of USERDATA Script

```
/var/lib/cloud/instance/user-data.txt
```

As the script is executed, the output of the script is located at

```
/var/log/cloud-init.log
```

It's also possible to use curl or wget to get at the script:

```
http://169.254.169.254/latest/user-data
```
