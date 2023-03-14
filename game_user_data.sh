#! /bin/sh
yum update -y

amazon-linux-extras install docker

service docker start

usermod -a -G docker ec2-user

chkconfig docker on

docker login
docker login --username <username> --password <password>

docker run -d -p 80:80 <username>/<imagename>
docker run -d --name watchtower -e REPO_USER=<username> -e REPO_PASS=<password> -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --schedule "0 * * * * *" --cleanup
