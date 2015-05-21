#/usr/bin/env bash

sudo yum update -y
sudo mkdir -p /etc/chef/ohai/hints/
sudo touch /etc/chef/ohai/hints/ec2.json
echo '{}' > ./ec2.json
sudo mv ./ec2.json /etc/chef/ohai/hints/ec2.json

