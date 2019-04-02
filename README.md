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
 sudo yum list|grep java-1.8
 sudo yum install java-1.8.0-openjdk-devel.x86_64 -y
 sudo update-alternatives --config java
 java -version
```
