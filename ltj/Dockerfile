FROM ubuntu:17.04

MAINTAINER brainchild GmbH <docker@brain-child.de>

# Add Java 8 repository
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu zesty main" > /etc/apt/sources.list.d/oracle-java.list
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

# Import all required repository keys
COPY updateKeys /tmp/
RUN /tmp/updateKeys
RUN rm /tmp/updateKeys

# Install required packages
RUN apt-get update && apt-get install -y --allow-unauthenticated \
    libservlet3.1-java \
    oracle-java8-installer \
    oracle-java8-set-default \
    tomcat8 \
    tomcat8-admin \
    tomcat8-docs \
    tomcat8-user \
    wget \
 && rm -rf /var/lib/apt/lists/*

# Setup environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV CATALINA_HOME /usr/share/tomcat8
ENV CATALINA_CONF /etc/tomcat8
ENV PATH $PATH:$CATALINA_HOME/bin
ENV WEBAPPS_DIR /webapps

RUN mkdir $WEBAPPS_DIR

# Configure Tomcat directories
RUN mkdir -p /usr/share/tomcat8/common/classes \
 && mkdir -p /usr/share/tomcat8/server/classes \
 && mkdir -p /usr/share/tomcat8/shared/classes \
 && mkdir $CATALINA_HOME/temp \
 && mkdir $CATALINA_HOME/webapps \
 && ln -s /var/lib/tomcat8/common $CATALINA_HOME/common \
 && ln -s /var/lib/tomcat8/server $CATALINA_HOME/server \
 && ln -s /var/lib/tomcat8/shared $CATALINA_HOME/shared \
 && ln -s $CATALINA_CONF $CATALINA_HOME/conf \
 && ln -s $WEBAPPS_DIR $CATALINA_HOME/webapps

VOLUME ["$CATALINA_CONF"]
VOLUME ["$WEBAPPS_DIR"]

EXPOSE 8080

CMD ["catalina.sh", "run"]

# Build the image
# docker build -t brainchild/ltj .

# First run
# docker run -v ~/<path to webapps>:/webapps -v ~/<path to tomcat config>:/etc/tomcat8 --name ltj -p 8080:8080 brainchild/ltj

# Sub-sequent runs
# docker docker start ltj
