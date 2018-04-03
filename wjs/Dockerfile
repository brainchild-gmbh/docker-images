# The Ubuntu version to be used. The name of the Ubuntu version must be used.
# The versions applicable can be found here
# https://hub.docker.com/r/library/ubuntu/tags/
ARG OS_VERSION

FROM microsoft/windowsservercore:${OS_VERSION}

MAINTAINER brainchild GmbH <docker@brain-child.de>

ARG OS_VERSION

# The version of the Java SDK to use. It must be the number provided by the Oracle Java
# download page: http://www.oracle.com/technetwork/java/javase/downloads/index.html.
ARG JAVA_VERSION=10

ADD entrypoint.ps1 'C:\entrypoint.ps1'
ADD java-install.cfg 'C:\java-install.cfg'
ADD jdk-${JAVA_VERSION}_windows-x64_bin.exe 'C:\install-jdk.exe'

RUN powershell -Command \
    Write-Host "" ; \
    Write-Host "Install Java SDK %JAVA_VERSION% ..." ; \
    Start-Process -filepath 'C:\install-jdk.exe' -passthru -wait -argumentlist 'INSTALLCFG=C:\\java-install.cfg /L C:\\install-jdk.log' ; \
    Write-Host "" ; \
    Write-Host "Remove intermediate files ..." ; \
    del C:\install-jdk.exe ; \
    del C:\java-install.cfg ; \
    del C:\install-jdk.log ; \
    Write-Host "Finished installing Java SDK %JAVA_VERSION%."
    
ENV JAVA_HOME "C:\\Program Files\\Java\\jre-${JAVA_VERSION}"
ENV JDK_HOME "C:\\Program Files\\Java\\jdk-${JAVA_VERSION}"

# The JRE and JDK folders must occurre first within the PATH in order to let
# there binaries be detected first.
RUN setx /M PATH "%JAVA_HOME%\bin;%JDK_HOME%\bin;%PATH%"

ENTRYPOINT powershell -executionPolicy bypass -file C:\entrypoint.ps1
