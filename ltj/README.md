# Linux Tomcat Java (LTJ) Docker Image
This docker image provides an [Ubuntu](https://ubuntu.com) based 
[Apache Tomcat](https://tomcat.apache.org) server. You may use it for development
purpose as well as for production environments.

## Operating LTJ
In order to ease operating LTJ a `docker-compose` file is provided. If you 
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
If you just run `docker-compose.yml` you will have a working Tomcat environment. 
The environment provides several ways to integrate your web applications and
configuration data.

In order to ease configuring the environment variables where introduced which 
are provided within the `.env` file. `docker-compose` reads this file and passes
the environment variables to the `docker-compose.yml` in order for variable 
substitution.

### BRAINCHILD\_LTJ\_VERSION
Specifies the release number of the brainchild LTJ image. In order to 
determine the versions available refer to 
[Docker brainchild/ltj](https://hub.docker.com/r/brainchild/ltj).

__Note:__ The latest version uses the keyword _latest_ as the release number.

### TOMCAT\_LOCAL\_PORT
This variable specifies the TCP port on the host to access the Tomcat server.

### WEBAPPS\_PATH
This variable can be used to specify the host filesystem path to the web 
applications to be run by Tomcat.

__Note:__ In order to use this environment variable the appropriate volume must
be enabled within the `docker-compose.yml`.

### CATALINA\_CONF
This variable is used to specify the host filesystem path to a custom Tomcat 
configuration.

__Note:__ In order to use this environment variable the appropriate volume must
be enabled within the `docker-compose.yml`.

## Building the brainchild LTJ image
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

### TOMCAT\_VERSION
The major version of Apache Tomcat to be used.

### LIB\_SERVLET\_VERSION
The version of the `Libservlet<version>-java` package to be used.

### Useful docker commands
If you want to remove all docker containers perform the following command:

    # Delete all containers
    docker rm $(docker ps -a -q)
    
If you want to remove all docker images perform the following command:

    # Delete all images
    docker rmi $(docker images -q)