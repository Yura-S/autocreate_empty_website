#!/bin/bash

cd ./packer/

packer build aws-ubuntu.pkr.hcl
if [[ $? != 0 ]]
  then
    echo "Something wrong while executing packer build"
    exit 1
fi

cd ../terraform/

terraform init
if [[ $? != 0 ]]; then
	echo "Something wrong while executing terraform init"
	exit 1
fi

terraform plan
if [[ $? != 0 ]]; then
	echo "Something wrong while executing terraform plan"
	exit 1
fi

terraform apply -auto-approve
if [[ $? != 0 ]]; then
	echo "Something wrong while executing terraform apply"
	exit 1
fi

URL=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=empty_website' --query 'Reservations[].Instances[].PublicIpAddress' --output text)
if [[ $? != 0 ]]
  then
    echo "Something wrong while getting website IP"
    exit 1
fi

echo "website ip is ${URL}"
