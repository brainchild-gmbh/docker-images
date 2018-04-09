# Windows Jenkins Slave (WJS)
This docker image provides a [Microsoft Windows](https://www.microsoft.com/windows) based
[Jenkins](https://jenkins.io) build slave. You may use it for development
purpose as well as for production environments.

## Operating WJS
In order to ease operating WJS a `docker-compose` file is provided. If you
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
If you just run `docker-compose.yml` you will have a working Jenkins Slave environment.

In order to ease configuring the environment variables where introduced which
are provided within the `.env` file. `docker-compose` reads this file and passes
the environment variables to the `docker-compose.yml` in order for variable
substitution.

### BRAINCHILD\_WJS\_VERSION
Specifies the release number of the brainchild WJS image. In order to
determine the versions available refer to
[Docker brainchild/wjs](https://hub.docker.com/r/brainchild/wjs).

__Note:__ The latest version uses the keyword _latest_ as the release number.

### JENKINS\_MASTER\_URL
This variable specifies the URL of the master Jenkins server.

### JENKINS\_USER
This optional variable specifies the user to be used for logging into the master Jenkins server.

### JENKINS\_PASSWORD
This optional variable specifies the password to be used for logging into the master Jenkins server.

### JENKINS\_LOCAL\_PORT
This variable specifies the TCP port on the host to access the Jenkins server.

## Building the brainchild WJS image
Building the image is quite easy. The Dockerfile was implemented to be
independent from the Microsoft Windows and Java version to be used. Those versions
have default values but can be overridden using build arguments:

    docker build -t brainchild/wjs:10.10.0 --build-arg OS_VERSION=ltsc2016 --build-arg JAVA_VERSION=10 .
    
__Note:__ The Oracle JDK to be used need to be downloaded first and placed into
the folder of the Docker file.

### OS\_VERSION
This mandatory variable specifies the operating system version to be used.

__Note:__ Only the name of the particular version must be used.
(see: [Microsoft Windows docker images](https://hub.docker.com/r/microsoft/windowsservercore)).

### JAVA\_VERSION
The version of Java to be used. The version must conform to the one encoded within
the Oracle JDK installer file name.

    jdk-<version>_windows-x64_bin.exe
    
    # Example using Java 10.
    jdk-10_windows-x64_bin

### Useful docker commands
If you want to remove all docker containers perform the following command:

    # Delete all containers
    docker rm $(docker ps -a -q)

If you want to remove all docker images perform the following command:

    # Delete all images
    docker rmi $(docker images -q)
