Week 7 : Task is on Infrastructure Provisioning and Configuration Management.

For this taks, I have chosen to deploy a NodeJS  application to an EC2 instance using a custom image built with Packer.

* Packer built by HashiCorp is a modern configuration management tool employing the use of automated scripts to install and configure the software within your Packer-made images. You can configure Packer images with an operating system and software for your specific use-case. Packer contains different blocks necessary to successfully build an image such as:
1. Variables — This determines the environment variables Packer will use for your AWS account. It contains the AWS access key and secret key. This region must match the region where the AMI will be created.
2. Builders — This creates an AMI that’s based on a specified size of Ubuntu image with Elastic Block Storage (EBS).
3. Provisioners — This builds out your instances with specific scripts or files.

* Ansible is an automation tool that uses YAML, in the form of Ansible Playbooks that allow you to describe your automation jobs in a way that approaches plain English. Playbooks can finely orchestrate multiple slices of your infrastructure topology, with very detailed control over how many machines to tackle at a time. Each playbook is composed of one or more ‘plays’ in a list. The goal of a play is to map a group of hosts to some well-defined roles, represented by things ansible calls tasks.
Now that we have defined some technologies, let’s dive in.
## Prerequisites

1. AWS account
2. Knowledge of Git/Github
3. Bash
4. Packer
5. Ansible

## Steps

**Install Packer**
### On Ubuntu

* curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
* sudo apt-add-repository “deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main”
* sudo apt-get update && sudo apt-get install packer

**Install Ansible**
### Ubuntu
* sudo apt update
* sudo apt install software-properties-common
* sudo apt-add-repository --yes --update ppa:ansible/ansible
* sudo apt install ansible

**Create AWS Environment Variables**

Create a directory in your local computer and cd into it. Inside this directory, create a .env file that will contain your AWS access key id and secret key and region. Add the file to the.gitignore to avoid getting pushed to the remote repository.
```
   export AWS_ACCESS_KEY_ID=
   export AWS_SECRET_ACCESS_KEY=
   export AWS_REGION=
```
## Build Custom Image 

* **template.json** file is a customized Packer template that creates the machine image using the configurqations specified.
* **ansible_playbook.yml** performs different tasks which will set up a NodeJs web app including all dependencies, configure an Nginx proxy server to make the app available to the internet, setup pm2 to make the application always available even when the instance is restarted.

* Run `bash build.sh` to provision the image.

## Launch EC2 Instance using the newly provisioned AMI

* Navigate to the EC2 dashboard our new AMI will be listed in the main window of the Images -> AMIs section.
* Launch an EC2 instance using the newly created AMI as our image. 
* Click on Launch and create a security group that will allow traffic from all sources via the port 3000.
* Choose a new or existing key pair and launch the instance.
* Copy the public IP address of the instance and paste on the browser.