# brainchild Odoo Postgres Docker Environment
The brainchild Odoo Postgres Docker Environment is intended to run Odoo using 
Docker for development purpose. It supports remote debugging with python.

The brainchild Odoo Postgres Docker Environment consists of a docker compose 
file combining Odoo and Postgress to provide a working Odoo working environment. 
It is based on the brainchild [Odoo docker image](https://hub.docker.com/r/brainchild/odoo) 
as well as an [official Postgress image](https://hub.docker.com/_/postgres/).

## Operating the brainchild Odoo Postgres environment
If you never started the `docker-compose.yml` you first need to create the environment.

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
If you just run `docker-compose.yml` you will have a working Odoo and Postgres
environment. If you'd like to use it for development purpose the environment
provides several ways to integrate your development environment with it.

In order to ease configuring the environment variables where introduced which 
are provided within the `.env` file. `docker-compose` reads this file and passes
the environment variables to the `docker-compose.yml` in order for variable 
substitution.

#### ODOO\_VERSION 
This environment variable provides the version number of Odoo to be used. It
is used to reference the proper brainchild Odoo docker image as well as to 
append it to the container name.

#### ODOO\_HTTP\_LOCAL\_PORT
This environment variable specifies the TCP port on the host to access the Odoo 
web interface.

#### ODOO\_EXTRA\_ADDONS\_PATH
This environment variable is used to provide custom addons to Odoo. In normal
case it will be used to provide the addons to be developed.

__Note:__ In order to use this environment variable the appropriate volume must
be enabled within the `docker-compose.yml`. 

#### ODOO\_ADDONS\_PATH
This environment variable is used to overwrite Odoo's global addons path and 
provide those available on the host. In normal case it will only be used if a 
different version of Odoo shall be used.

__Note:__ In order to use this environment variable the appropriate volume must
be enabled within the `docker-compose.yml`.

#### ODOO\_CONFIG\_PATH
This environment variable is used to provide a custom configuration to Odoo.

__Note:__ In order to use this environment variable the appropriate volume must
be enabled within the `docker-compose.yml`.

#### POSTGRES\_VERSION 
This environment variable provides the version number of Postgres to be used. It
is used to reference the proper Postgres docker image as well as to 
append it to the container name.

#### POSTGRES\_LOCAL\_PORT
This environment variable specifies the TCP port on the host to access the
Postgres database.

#### POSTGRES\_DATA\_PATH
This environment variable is used to provide a path to which Postgres shall 
store its database data to. This is useful if the data shall be used in 
different containers or to provide a predefined data set to Postgres.

__Note:__ In order to use this environment variable the appropriate volume must
be enabled within the `docker-compose.yml`.

## Remote debugging Odoo
Remote debugging Odoo or a Python application in general is done using a so 
called PyDev server. The host runs the server and the target, i.e. Odoo 
connects to it. When the target connects to the server the server stops 
execution and shows the code it stopped at within the IDE running the server.

### Verifying if remote debugging works
The Odoo docker container provides a script which just connects to a PyDev 
server. In order to verify the remote debugging works at all you first need 
to start the PyDev Debug Server on the host using your favorite IDE. When the 
server is started it prints the TCP port it listens on for incoming connections. 
You need to note this port number. Now get into the `bash` of the Odoo docker 
container:

	docker exec -t -i <container> /bin/bash
	
	# Example
	docker exec -t -i odoo10.0 /bin/bash

As mentioned above the Odoo docker image provides a Python script which 
connects to a PyDev server. The only thing you need to know is the host's DNS 
name or IP and the port the server is listening on. Within the Odoo `bash` 
execute the test script.

	./test-remote-debug.py <host> <pydev server port>
	
	# Docker on macOS  
	./test-remote-debug.py docker.for.mac.localhost 7999
	
Now the IDE should show the code it stopped execution at. Maybe it asks for the location of the script on the host first.

## Building the brainchild Odoo image
Building the image is quite easy. The Dockerfile was implemented to be 
independent from the Odoo and _wkhtmltox_ version to be used. Those versions
have default values but can be overridden using build arguments:

    docker build -t brainchild/odoo:10.0 --build-arg OS_VERSION=jessie --build-arg ODOO_VERSION=10.0 --build-arg ODOO_RELEASE=latest --build-arg WKHTMLTOX_VERSION=0.12.4 .

__Note:__ The following files are built into image:

- entrypoint.sh
- odoo.conf
- test-remote-debug.py

### OS\_VERSION
This mandatory variable specifies the operating system version to be used. Only
those versions can be used for which Odoo is available 
(see: [Odoo builds page](http://nightly.odoo.com)).

### ODOO\_VERSION
Specifies the version of Odoo for which to build the image. In order to 
determine the versions available refer to [Odoo builds page](http://nightly.odoo.com).
The files provided there conform to the following format:

    odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb
    
### ODOO\_RELEASE
Specifies the release number of Odoo for which to build the image. In order to 
determine the versions available refer to [Odoo builds page](http://nightly.odoo.com).
The files provided there conform to the following format:

    odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb

__Note:__ The latest version uses the keyword _latest_ as the release number.

### ENV\_WKHTMLTOX\_VERSION
Specifies the version of _wkhtmltox_ for which to build the image. In order to 
determine the versions available refer to 
[Odoo extras builds page](http://nightly.odoo.com/extra).
The files provided there conform to the following format:

    wkhtmltox-${WKHTMLTOX_VERSION}_linux-jessie-amd64.deb

### Useful docker commands
If you want to remove all docker containers perform the following command:

    # Delete all containers
    docker rm $(docker ps -a -q)
    
If you want to remove all docker images perform the following command:

    # Delete all images
    docker rmi $(docker images -q)
