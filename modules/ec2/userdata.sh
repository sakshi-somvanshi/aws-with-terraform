#!/bin/bash

apt-get update -y
apt-get install -y awscli

echo "S3 VPC Endpoint Demo Instance Ready" > /home/ubuntu/endpoint-demo.txt