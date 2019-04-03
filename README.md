# Cloudformation
# CFN (cloudformation template)-Validation on Jenkins Pipeline
## Table of Contents
## Installing Jenkins on AWS.
### Two Linux Machines is Required(Our Example is Based on AWS Jenkins master-slave CFN validation )

```
Launch an EC2 Instance naming as jenkins-master
```
java is prerequisite to install jenkins.

```
### Execute the below commands to find the latest java jdk version and install update to its latest version.
```
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
Paste the publicIP:8080  (on which port the jenkins is running) on web browser and login to the jenkins install plugins and provide the credentials
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
Go to  Manage jenkins-->manage Nodes--> New Node-->create
 
 Configure-->
 Follow the Mandatory fields should be filled
 Name-->
 Remote root directory	-->path of your jenkins user
 Labels--> Restrict the permissions to particular Label eg:slave3
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
  Under jenkins create a project directory where our project files should be kept under this directory.
 ``` 
 ```sh
 $mkdir cfn
 $cd cfn
 ```
 ```
 make a directory that  contains cloudformation templates written in json or yaml.
 ```
 ```sh
 $mkdir valid_tempalte
 $cd valid_template
 $vi test.json
 $vi cfn_test.json
 $pwd
 ```
 
 ### Go to Jenkins Dashboard
 ```
 New Item-->Freestyle job-->Configure-->
 Restrict where this project can be run--Label Expression(	Label slave3 is serviced by 1 node. Permissions or other restrictions        provided by plugins may prevent this job from running on those nodes.)
 Source Code Management-->
 provide the mandatory details-->
 Repository URL->Specify the URL of this remote repository. This uses the same syntax as your git clone command.
 Credentials ->provide your github username & password
 Branches to build->Specify the branches if you'd like to track a specific branch in a repository. If left blank, all branches will be    examined for changes and built.
 ```
 ```
 Build Actions(Execute shell command)
 To test the cloudformation template written in json or yaml syntax follow the below command.
 shell command
```
```sh
#!/bin/sh
pwd
#for i in $(ls | grep '.json\|.yaml'); do   cfn-lint $i; done
mkdir -p valid_template
for i in $(ls | grep '.json\|.yaml'); do    cfn-lint $i;    if [ $? == 0 ];    then        cp $i valid_template/$i;    fi; done
```
```
 ```
 Save-->Build Now-->Build Success(Console output)
 ```
 ```
 If we provide any invalid template then Build Failure(Console output)
 
 ### Storing Jenkins output to AWS S3 bucket.
 ```
 Here is a list of topics we would cover in this tutorial to achieve S3 output: –

Create a S3 bucket.
Create an IAM User , Access Key  and assign a Managed Policy to Read/Write to the specific folder.
Install S3 Plugin on Jenkins
Configure the S3 profile

### Create a Bucket

1. Sign in to the AWS Management Console and open the Amazon S3 console at https://console.aws.amazon.com/s3/.
2. Click “Create Bucket”
3. Select Bucket name and Region. The name that you choose must be unique across all existing bucket names in Amazon S3 and remember to use only lowercase chars as it doesn’t accept certain combinations.  .
4. Create the bucket with or without logging as per your choice.
5. Create a folder to store your output in a specific folder.
Configure a Post-Build Step to upload output to S3 bucket.
```
```

### Step 2 – Create an IAM User and assign a Group & Policy to Read/Write to the specific folder.

Step 2A – To Create IAM User(s) with AWS IAM console
1. Sign in to the Identity and Access Management (IAM) console at https://console.aws.amazon.com/iam/.
2. In the navigation pane, choose Users and then choose Create New Users.
3. Type in user name = jenkinsuploader
4. Since our user would need to access AWS API from S3 plugin, we would need to generate access keys. To generate access key for new users at this time, select Generate an access key for each user. Remember that you will not have access to the secret access keys again after this step. if you lose them, you need to create a new Access Key for this IAM User.
5. Choose Create and then either show Key or Download Credentials in form of CSV.
6. Since we want to use just this IAM User for POC, we would be assigning the Managed Policy specific to the user. However, it is recommended to assign Managed policies to Groups and then map the users to the Group. Proceed to next step (Step 2B) to Create and Assign a Policy.
```
### Step 2B – Create a Customer policy and Assign to user 
```
Sign in to the Identity and Access Management (IAM) console at https://console.aws.amazon.com/iam/.
In the navigation pane, choose Policies and then choose Create Policy
Select ‘Create your Own Policy’ and select policy name as ‘templateUploaders’ and paste the below JSON as Policy Document
{
   "Version": "2012-10-17",
   "Statement": [
    {
     "Sid": "AllowUserToReadWriteObjectDataInapkarchive",
     "Action": [
       "s3:PutObject",
       "s3:GetObject"
        ],
     "Effect": "Allow",
     "Resource": [
       "arn:aws:s3:::bucketname/folder",
       "arn:aws:s3:::bucketname/folder/*"
      ]
    }
   ]
}
```
```
4.  Go to “Attached Entities” Tab and “Attach” to the IAM user we created in Step 2A  above.

With this step the S3 bucket and our IAM user access id and secret keys are ready to be configured on Jenkins, so lets proceed to next step.
```


### Step 3 – Install S3 Plugin

Logon to Jenkins Dashboard with administrative id  and perform below steps to download S3 plugin automatically.

navigate to Jenkins dashboard -> Manage Jenkins -> Manage Plugins and select available tab. Look for “S3 plugin” and install that.
You could also download the HPI file from S3 plugin URL and paste in Plugins directory of the Jenkins installation.
Once done installation, restart Jenkins to take effect.
 ```
 ```
### Step 4 – Configure the S3 profile

Go to Manage Jenkins and select “Configure System” and look for “Amazon S3 Profiles” section. Provide a profile name, access key and secret access key for your jenkinsuploader account that we created above.


### Step 5. Configure a Post-Build Step to upload **/*. files  to S3 bucket.  
```
Publish artifacts to S3 
Source – **/*/*
Destination – bucketname/foldername  format (The plugin accepts bucketname followed by absolute path to the folder in which the build output has to be stored.)
Storage Class – Standard
Bucket Region – Depending on your bucket’s region.
Manage artifacts – true  (This would ensure the S3 Plugin manages and keeps the build outputs as per the Jenkins archival policy)
Server side encryption – True / False (as per your bucket’s encryption policy)

Now, click on save and you are done !!

All your build artifacts will get uploaded to Amazon S3 bucket.
```
