#!/bin/bash

# Run the AWS EC2 instance
instance_id=$(aws ec2 run-instances \
    --image-id ami-0acb327475c6fd498 \
    --count 1 \
    --region us-east-2 \
    --instance-type t4g.small \
    --key-name laravel-ansible \
    --security-group-ids sg-0af6ead5bcc6830b4 \
    --subnet-id subnet-ab10aec2 \
    --block-device-mappings 'DeviceName=/dev/sda1,Ebs={VolumeSize=40,VolumeType=gp3}' \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Laravel-ansible}]' \
    --profile personal \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "Instance ID: $instance_id"

# Wait until the instance is in 'running' state
aws ec2 wait instance-running --instance-ids "$instance_id" --region us-east-2 --profile personal

# Get the public IP address of the instance
public_ip=$(aws ec2 describe-instances \
    --instance-ids "$instance_id" \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text \
    --region us-east-2 \
    --profile personal)

echo "Public IP: $public_ip"
echo "ssh -i ./secrets/laravel-instance.pem ubuntu@$public_ip"  > connect.sh
echo "ansible_python_interpreter=/usr/bin/python3
[server]
$public_ip" > inventory.ini
