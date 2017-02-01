FROM ubuntu:17.04

MAINTAINER brainchild GmbH <docker@brain-child.de>

# Install packages required later
RUN apt-get update && apt-get install -y --allow-unauthenticated \
    software-properties-common \
    gdebi-core \
    wget

# Add APT repository
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu zesty main" > /etc/apt/sources.list.d/oracle-java.list
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections
RUN echo "deb http://download.eclipse.org/package-drone/release/current/ubuntu package-drone default" > /etc/apt/sources.list.d/pkgdrone.list

# Import all required repository keys
COPY updateKeys /tmp/
RUN /tmp/updateKeys
RUN rm /tmp/updateKeys

# Install packages
RUN apt-get update && apt-get install -y --allow-unauthenticated \
    oracle-java8-installer \
    oracle-java8-set-default \
    org.eclipse.packagedrone.server \
 && rm -rf /var/lib/apt/lists/*

# Setup environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# PackageProne is running on port 8080
EXPOSE 8080

CMD ["/usr/lib/package-drone-server/instance/server"]

# Build the image
# docker build -t brainchild/pkgdrone .

# First run
# docker run --name pkgdrone -p 8080:8080 brainchild/pkgdrone

# Sub-sequent runs
# docker start pkgdrone
