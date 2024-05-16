# ubuntu arm base instance
# --image-id ami-0a55ba1c20b74fc30 \
# provisioned instance
aws ec2 run-instances \
    --image-id ami-asfasdfas \
    --count 1 \
    --instance-type c7g.large \
    --key-name key-2024-04-08 \
    --security-group-ids sg-3423 sg-23423 sg-23423 \
    --subnet-id subnet-234423 \
    --block-device-mappings 'DeviceName=/dev/sda1,Ebs={VolumeSize=40,VolumeType=gp3}' \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=App-2024}]' \
    --iam-instance-profile Name=App-instance --profile your-aws-profile
