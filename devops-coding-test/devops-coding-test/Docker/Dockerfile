# Use the CentOS base image
# I am using centos because in the question mentioned to use yum package manager to install wget git unzip java-1.8.0-openjdk-devel these package
# to reduce imagesize we can use alpine linux as a base image
FROM centos:latest

# Install necessary packages
RUN yum -y update && \
    yum -y install tar wget git unzip java-1.8.0-openjdk-devel && \
    yum clean all

# Create usergroup "jenkins" and user "jenkins"
RUN groupadd -r jenkins && useradd -r -g jenkins jenkins

# Set the working directory to the home directory of user "jenkins"
WORKDIR /home/jenkins

# Switch to user "jenkins" for subsequent commands
USER jenkins

# Download Jenkins war file
RUN wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war

# Run Jenkins using java -jar jenkins.war
CMD ["java", "-jar", "jenkins.war"]
