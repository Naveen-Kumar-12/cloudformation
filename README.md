# cloudformation
# CFN (cloudformation template)-Validation on Jenkins Pipeline
## Table of Contents
## Installing Jenkins on AWS.
### Two Linux Machine is Required(Our Example is Based on AWS Jenkins master-slave CFN validation )

```
Launch EC2 Instance naming as jenkins-master
```
java is prerequisite to install jenkins.

```
### Execute the below commands to find the latest java jdk version and install update to its latest version.
```sh
 $sudo yum list|grep java-1.8
 $sudo yum install java-1.8.0-openjdk-devel.x86_64 -y
 $sudo update-alternatives --config java
 $java -version
```
### Install jenkins on master machine by following its [official installation guide] (https://pkg.jenkins.io/redhat-stable/)
```sh
$sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
$sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
$yum install jenkins
```
### start the jenkins and enable jenkins jenkins on reboot & give the credentials to login to jenkins
```sh
$sudo service jenkins start
$sudo chkconfig jenkins on
$sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
```
Paste the public IP:8080 (on which port the jenkins is running) and login to the jenkins install plugins and provide te credentials
```
### Jenkins-master machine change the ec2-user to jenkins under /bin/bash to access to it.
```sh
 [ec2-user@ip-172-31-34-181 ~]$ sudo su jenkins -s /bin/bash
 ```
 Run the commands under /var/lib/jenkins(jenkins path)
 ```
 ```sh
 bash-4.2$ cd /var/lib/jenkins
 ```
 Generate public and private keys and execute the below command.
 ```sh
 bash-4.2$ ssh-keygen
 ```
 After executing the commands it generates two keys id_rsa & id_rsa.pub.
 
 ### Login to jenkins-slave Machine
 ### Find the latest java jdk version and install update to its latest version. Else copy from the previous java related commands
  ```
 Change the user to root user
 ```
 ```sh
 $sudo su
 ```
Run sudo command without password
```sh
#sudo visudo
#jenkins ALL=(ALL) NOPASSWD: ALL
```
```
Add the jenkins user and specify the path
```
```sh
#useradd -d /var/lib/jenkins jenkins
```
change the root user to jenkins user 
```
#su jenkins

``` 
```
change directory to jenkins user path
```
```sh
[jenkins@ip-172-31-43-73 ~]$ cd /var/lib/jenkins
```
create directory .ssh under this directory create a file naming as authorized_keys
```
```sh

[jenkins@ip-172-31-43-73 ~]$ mkdir .ssh
cd .ssh
[jenkins@ip-172-31-43-73 .ssh]$ vi authorized_keys
```
```
give the permissions to .ssh and authorized_keys
```
```sh
$chmod 700 .ssh
$chmod 640 authorized_keys
```

```
copy the content of  id_rsa.pub from master machine and paste it to slave autorized_keys
```
```
check the connection from master ssh to private ip of slave machine
```
```sh
bash-4.2$ ssh privateip

```
### Jenkins Dashboard
```
 manage jenkins-->manage Nodes--> New Node-->create
 
 Configure-->
 Follow the Mandatory fields should be filled
 Name-->
 Remote root directory	-->path of your jenkins user
 Labels--> Restrict the permissions to partvular Label
 Usage--> Always prefer node available as much as possible
 Launch method --> Launch via ssh agent method
  
 Host-->private ip of the slave
 Credentials--> SSH username with private key
 Host Key Verification Strategy--> known hosts file verification strategy
 Availability-->keep agent available as much as possible
 Save-->Launch Agent--> agent added successfully
 ```
 ### Go to jenkins-slave Machine & execute the below commands.
 ```
 ### Install pip(python-package-manager) is used to install third-party modules which can integrated with python
 ```
 ```sh
 [jenkins@ip-172-31-43-73 ~]$  sudo python get-pip.py
 ```
 ```
 ### Install git to integrate with github repositories or bitbucket repos.
 ```
 ```sh
 $ sudo yum install git -y
 ```
 ```
 ### Install cfn-lint by following these steps
 ```
 ```
 ###clone the existing  github repo and copy files it into your server
 ```
 ```sh
 $git clone https://github.com/aws-cloudformation/cfn-python-lint.git
 ```
 ```
 ###list of files  is executed when we run above command
 ```
 change directory to cfn-python-lint
 ```
 ```sh
 $cd cfn-python-lint/
 ```
 ```
 we have to execute these commands to install whole package
 ```
 ```sh
 $sudo pip install setuptools -U
 $sudo python setup.py install
 ```
 ```
 if any installed package raises command not found then add the path it to env and activate
 ```
 ```sh
 $vi ~/.bash_profile
 $source ~/.bash_profile
 ```
 
