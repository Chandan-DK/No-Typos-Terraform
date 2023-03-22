# No-Typos-Terraform 🌏

Hi! This is the repository which has Terraform files to host my game <a href="https://github.com/Chandan-DK/No-Typos">NoTypos</a> on AWS
<br/>

Unity WebGL build files are present in <a href="https://github.com/Chandan-DK/No-Typos-Build">No-Typos-Build</a> repository
<br/> Other files such as dockerfile, buildspec.yml, build-image.sh and push-image.sh are present in that repository for hosting the game on AWS

## Architecture Diagram 🗺️

<p>
<img src="https://user-images.githubusercontent.com/103727912/224962373-d33eab99-faaa-4695-b371-5ec375e66e40.png"/>
</p>


## How is the Hosting Done? 💻

* In my AWS account, a User is made in IAM with appropriate permissions and access keys are created for that user
* Game's initial image is pushed to a private repository that is set up on Docker Hub.
* All the values for the variables in variables.tf file are stored in a secrets.auto.tfvars file 
  which is ignored by git 
* When Terraform code of this repository is executed, it sets up the infrastructure within my AWS account
* A script is run during the creation of the EC2 instance which installs Docker and Watchtower in it.
  <br/>It also runs the game's docker image by pulling it from Docker Hub
* Pushing code to No-Typos-Build repository causes AWS CodeBuild to be triggered 
* AWS CodeBuild makes a Docker image from the Dockerfile which is present in No-Typos-Build repository and updates the game's image in Docker Hub
* Watchtower is scheduled to check for updates to the game's image every minute
* If an update is found, it stops the running game's container and starts a new container with the updated image

## Video 🎥

Here's a video I made to showcase the hosting of the game

<a href="https://youtu.be/Kw7LHTxzS3E"><img src="https://user-images.githubusercontent.com/103727912/226766236-59a7d08b-ad11-425a-90f0-6369d5e40e64.png" alt="ALT TEXT HERE" width="320" height="180"></a>