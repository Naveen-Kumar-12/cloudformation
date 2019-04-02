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

