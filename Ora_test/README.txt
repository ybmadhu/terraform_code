Java

Q1. There are three tasks and which we expect you to come up with the most optimized and clean solution for any of the two problems: PalindromeUtil, BlockingQueue, MyHashMap.

Each task should be solved by completing a corresponding java class in src/ora cle/test directory so it compiles and works in accordance to contract defined in javadoc comments.

We also expect you to write sufficient amount of tests for your implementations in a corresponding java class in test/oracle/test directory. You can implement tests using JUnit, TestNG framework or without a test framework.


Jenkins

Q2. Write a Jenkins Pipeline script to do the following.
Following are the different steps that need to be included in the Jenkins pipeline script(Jenkinsfile)
    a. Initialize step which performs checkout from a git repo https://github.com/somegitrepo.git
    b. Build Step – mvn clean install. Execute maven build command
    c. Complete Step – Display a message “Build is complete”

Shell Scripting

Q3: Write a crontab entry to remove all files that begin with two lower case characters, followed by two numbers, and followed by .txt in your home directory every Monday at 2am

Q4: Write a script called user_checking.sh that will:
•   Take a command line argument: user's login name
•   Check to see if a command line argument was provided.
•   Check to see if the user is in the /etc/passwd. If so, will print: "Found user name in the /etc/passwd file." Otherwise, will print: "ERROR: user name not found."

Q5: Write a shell script that reads a file located in “/tmp/version.txt” and replace all occurrence of version 2.1.1 with 2_1_1?

Containers/Docker

Q6. Create a docker image that perform the following
Note: You could use base image of your choice

    a. Create a usergroup “jenkins” and user “jenkins”
    b.Install following packages using yum tar wget git unzip java-1.8.0-openjdk-devel
    c.Run following process as user “jenkins” which you created above
    d.Download Jenkins war from http://mirrors.jenkins.io/war-stable/latest/jenkins.war.
    e.Execute the command java -jar jenkins.war at the end
Q6.1: How will you build and push this image?
Q6.2. How will you run this image exposing the default port 8080?


When you are done, please put java files, this README and all other solution files into a zip archive and send it back over email.
(please do not include any .class files when you zip it, to avoid attachments being removed by mail server)