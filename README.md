# No-Typos-Terraform 🌏

Hi! This is the repository which has Terraform files to host my game <a href="https://github.com/Chandan-DK/No-Typos">NoTypos</a> on AWS
<br/>

Unity WebGL build files are present in <a href="https://github.com/Chandan-DK/No-Typos-Build">No-Typos-Build</a> repository
<br/> Other files such as dockerfile, buildspec.yml, build-image.sh and push-image.sh are present in that repository for hosting the game on AWS

## How is The Hosting Done? 💻

* In AWS, a User is made in IAM with appropriate permissions and access keys are created for that user
* Game's initial image is pushed to a private repository that is set up on Docker Hub.
* All the values for the variables in variables.tf file are stored in a secrets.auto.tfvars file 
  which is ignored by git 
* When Terraform code of this repository is executed, it sets up AWS CodeBuild and an EC2 instance
* A script is run during the creation of the EC2 instance which installs Docker and Watchtower in it.
  <br/>It also runs the game's docker image by pulling it from Docker Hub
* Pushing code to No-Typos-Build repository causes AWS CodeBuild to be triggered 
* AWS CodeBuild makes a Docker image from the dockerfile which is present in No-Typos-Build repository and updates the game's image in Docker Hub
* Watchtower is scheduled to check for updates to the game's image every minute
* If an update is found, it stops the running game's container and starts a new container with the updated image