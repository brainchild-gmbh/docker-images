# Linux Tomcat Java Docker Image
Official source of the [Docker](https://www.docker.com) image 
[brainchild/ltj](https://hub.docker.com/r/brainchild/ltj). It is based on Ubuntu and 
provides a [Tomcat](https://tomcat.apache.org) server using the latest 
[Oracle Java](http://www.oracle.com/technetwork/java/javase/downloads/index.html) from 
https://launchpad.net/~webupd8team/+archive/ubuntu/java.

# Using the image
`docker pull brainchild/ltj`

# Building the image
If you want to build this Docker image by yourself perform the following command with in shell.

`docker build -t brainchild/ltj .`

# Running the image
## First run
The first time you run the image you can setup your environment:
*   **<path to webapps>:** Directory of the web applications to be served by tomcat. 
You can ommit this option if you do not want to provide your web applications 
this way. In this case you can use the normal deployment way.
*   **<path to tomcat config>:** Directory of your tomcat configuration files. You can 
ommit this option if want to use the standard configuration files provided by tomcat.
*   **<container name>:** The name for the Docker container.
*   **<port>:** The TCP port to access tomcat on your host machine.
 
`docker run -v <path to webapps>:/webapps -v <path to tomcat config>:/etc/tomcat8 --name <container name> -p <port>:8080 brainchild/ltj`

## Sub-sequent runs
On sub-sequent runs you can use the container name you specified on the first run.
`docker docker start <container name>`

