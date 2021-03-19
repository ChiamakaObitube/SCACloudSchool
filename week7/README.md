Week 7 : Task is on Infrastructure Provisioning and Configuration Management.

For this taks, I have chosen to deploy a NodeJS  application to an EC2 instance using a custom image built with Packer.


* Ansible is an automation tool that uses YAML, in the form of Ansible Playbooks that allow you to describe your automation jobs in a way that approaches plain English. Playbooks can finely orchestrate multiple slices of your infrastructure topology, with very detailed control over how many machines to tackle at a time. Each playbook is composed of one or more ‘plays’ in a list. The goal of a play is to map a group of hosts to some well-defined roles, represented by things ansible calls tasks.
Now that we have defined some technologies, let’s dive in.
## Prerequisites

1. AWS account
2. Knowledge of Git/Github
5. Ansible

## Steps

**Install Ansible**
### Ubuntu
* sudo apt update
* sudo apt install software-properties-common
* sudo apt-add-repository --yes --update ppa:ansible/ansible
* sudo apt install ansible

**Configure AWS credentials**
Copy your access key ID and export in the command line.
```
   export AWS_ACCESS_KEY_ID=
   export AWS_SECRET_ACCESS_KEY=
   export AWS_REGION=
```

* Launch an EC2 Instance from the AWS portal

* Create a directory in /etc/ directory - ```mkdir /etc/ansible```
Inside the directory, create a **ansible.cfg** file and copy the commands below;

```
[defaults]
private_key_file=path_to_my_key/my_key.pem
remote_user = ubuntu
```


* Create a **hosts** file and copy the contents below

```
[myServers]
Public_IP_of_remote_server
```

I used an Elastic IP address so that my server is available on the same IP  even when the instance is restarted.

* Copy the contents of the playbook in the ***ansible_playbook.yml*** file

* Run the playbook using the command ```sudo ansible-playbook ansible_playbook.yml```