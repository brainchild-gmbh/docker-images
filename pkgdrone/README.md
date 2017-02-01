# Eclipse Package Drone Docker Image
Official source of the [Docker](https://www.docker.com) image 
[brainchild/pkgdrone](https://hub.docker.com/r/brainchild/pkgdrone). It is based 
on [Ubuntu](https://ubuntu.com) and provides an 
[Eclipse Package Drone](https://packagedrone.org) server from http://download.eclipse.org/package-drone/release/current/ubuntu using the latest 
[Oracle Java](http://www.oracle.com/technetwork/java/javase/downloads/index.html) from 
https://launchpad.net/~webupd8team/+archive/ubuntu/java.

# Using the image
`docker pull brainchild/pkgdrone`

# Building the image
If you want to build this Docker image by yourself perform the following command with in shell.

`docker build -t brainchild/pkgdrone .`

# Running the image
## First run
The first time you run the image you can setup your environment:
*   **<container name>:** The name for the Docker container.
*   **<port>:** The TCP port to access the Eclipse Package Drone server on your host machine.
 
`docker run --name <container name> -p <port>:8080 brainchild/pkgdrone`

## Sub-sequent runs
On sub-sequent runs you can use the container name you specified on the first run.
`docker docker start <container name>`

