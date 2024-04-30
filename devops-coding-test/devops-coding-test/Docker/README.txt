you can build the Docker image using the following command:

$ docker build -t jenkins_image .

you can run a container from the image:

$ docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure --name jenkins_container jenkins_image

You can access Jenkins by visiting

 http://<ipaddress>:8080 in your web browser.



