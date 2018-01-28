# The Ubuntu version to be used. The name of the Ubuntu version must be used.
# The versions applicable can be found here
# https://hub.docker.com/r/library/ubuntu/tags/
ARG OS_VERSION

FROM ubuntu:${OS_VERSION}

MAINTAINER brainchild GmbH <docker@brain-child.de>

ARG OS_VERSION

# The version of Java to use. It must be an integer number. It refers to the 
# version of the packacke name.
ARG JAVA_VERSION=9

# Install packages required later
RUN set -x; \
        apt-get update \
    && apt-get install -y --allow-unauthenticated --install-recommends \
        software-properties-common \
        gdebi-core \
        wget \
        dirmngr

# Add Java and package drone repositories
RUN set -x; echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu ${OS_VERSION} main" > /etc/apt/sources.list.d/oracle-java.list
RUN set -x; echo "oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections
RUN set -x; echo "deb http://download.eclipse.org/package-drone/release/current/ubuntu package-drone default" > /etc/apt/sources.list.d/pkgdrone.list

# Import all required repository keys
COPY updateKeys /tmp/
RUN /tmp/updateKeys
RUN rm /tmp/updateKeys

# Install packages
RUN set -x; \
       apt-get update \
    && apt-get install -y --allow-unauthenticated \
        oracle-java${JAVA_VERSION}-installer \
        oracle-java${JAVA_VERSION}-set-default \
        org.eclipse.packagedrone.server \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

# Setup environment variables
ENV JAVA_HOME /usr/lib/jvm/java-${JAVA_VERSION}-oracle

# PackageProne is running on port 8080
EXPOSE 8080

CMD ["/usr/lib/package-drone-server/instance/server"]