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

# The version of Apache Tomcat to use. It must be an integer number. It refers 
# to the version of the packacke name.
ARG TOMCAT_VERSION=8

# The libservlet version to use. It refers to the version of the packacke name.
ARG LIB_SERVLET_VERSION=3.1

# Install dirmngr for importing missing GPG keys
RUN set -x; \
    apt-get update \
 && apt-get install -y --allow-unauthenticated --install-recommends \
    dirmngr

# Add Java repository
RUN set -x; echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu ${OS_VERSION} main" > /etc/apt/sources.list.d/oracle-java.list
RUN set -x; echo "oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

# Import all required repository keys
COPY updateKeys /tmp/
RUN /tmp/updateKeys
RUN rm /tmp/updateKeys

# Install required packages
RUN set -x; \
    apt-get update \
 && apt-get install -y --allow-unauthenticated \
    libservlet${LIB_SERVLET_VERSION}-java \
    oracle-java${JAVA_VERSION}-installer \
    oracle-java${JAVA_VERSION}-set-default \
    tomcat${TOMCAT_VERSION} \
    tomcat${TOMCAT_VERSION}-admin \
    tomcat${TOMCAT_VERSION}-docs \
    tomcat${TOMCAT_VERSION}-user \
    wget \
 && apt-get clean \
 && apt-get autoclean \
 && rm -rf /var/lib/apt/lists/*

# Setup environment variables
ENV JAVA_HOME /usr/lib/jvm/java-${JAVA_VERSION}-oracle
ENV CATALINA_HOME /usr/share/tomcat${TOMCAT_VERSION}
ENV CATALINA_CONF /etc/tomcat${TOMCAT_VERSION}
ENV PATH ${PATH}:${CATALINA_HOME}/bin
ENV WEBAPPS_DIR /webapps

RUN mkdir $WEBAPPS_DIR

# Configure Tomcat directories
RUN set -x; \ 
    mkdir -p /usr/share/tomcat${TOMCAT_VERSION}/common/classes \
 && mkdir -p /usr/share/tomcat${TOMCAT_VERSION}/server/classes \
 && mkdir -p /usr/share/tomcat${TOMCAT_VERSION}/shared/classes \
 && mkdir ${CATALINA_HOME}/temp \
 && mkdir ${CATALINA_HOME}/webapps \
 && ln -s /var/lib/tomcat${TOMCAT_VERSION}/common $CATALINA_HOME/common \
 && ln -s /var/lib/tomcat${TOMCAT_VERSION}/server $CATALINA_HOME/server \
 && ln -s /var/lib/tomcat${TOMCAT_VERSION}/shared $CATALINA_HOME/shared \
 && ln -s ${CATALINA_CONF} ${CATALINA_HOME}/conf \
 && ln -s ${WEBAPPS_DIR} ${CATALINA_HOME}/webapps

VOLUME ["$CATALINA_CONF"]
VOLUME ["$WEBAPPS_DIR"]

EXPOSE 8080

CMD ["catalina.sh", "run"]