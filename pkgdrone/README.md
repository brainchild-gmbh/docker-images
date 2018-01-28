# Eclipse Package Drone (EPD) Docker Image
This docker image provides an [Ubuntu](https://ubuntu.com) based 
[Eclipse Package Drone](https://eclipse.org/package-drone) server.

## Operating Eclipse Package Drone
In order to ease operating EPD a `docker-compose` file is provided. If you 
never started the `docker-compose.yml` you first need to create the environment.

Within a terminal type:

    docker-compose up --no-start

If the environment was created you can start it using the command:

    docker-compose start
    
In order to stop the environment perform the following command:

    docker-compose stop
    
If want to stop and start the environment again just type

    docker-compose restart
    
If you want to remove the environment e.g. if you want to entirely create it 
again execute

    docker-compose down

### Environment
If you just run `docker-compose.yml` you will have a working EPS server.

In order to ease configuring the environment variables where introduced which 
are provided within the `.env` file. `docker-compose` reads this file and passes
the environment variables to the `docker-compose.yml` in order for variable 
substitution.

### BRAINCHILD\_PKGDRONE\_VERSION
Specifies the release number of the brainchild EPD image. In order to 
determine the versions available refer to 
[Docker brainchild/pkgdrone](https://hub.docker.com/r/brainchild/pkgdrone).

__Note:__ The latest version uses the keyword _latest_ as the release number.

### PKGDRONE\_LOCAL\_HTTP\_PORT
Specifies the TCP port on the host to access the EPD web interface.

## Building the brainchild EPS image
Building the image is quite easy. The Dockerfile was implemented to be 
independent from the Ubuntu Tomcat and Java version to be used. Those versions
have default values but can be overridden using build arguments:

    docker build -t brainchild/ltj:18.8.9 --build-arg OS_VERSION=bionic --build-arg JAVA_VERSION=9 --build-arg TOMCAT_VERSION=8 

### OS\_VERSION
This mandatory variable specifies the operating system version to be used. 

__Note:__ Only the name of the particular version must be used. 
(see: [ubuntu docker images](https://hub.docker.com/_/ubuntu)).

### JAVA\_VERSION
The major version of Java to be used.

### Useful docker commands
If you want to remove all docker containers perform the following command:

    # Delete all containers
    docker rm $(docker ps -a -q)
    
If you want to remove all docker images perform the following command:

    # Delete all images
    docker rmi $(docker images -q)