# Use the official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables
ENV JETTY_VERSION=9.4.43.v20210629 \
    JETTY_HOME=/opt/jetty

    

# Install Java and Jetty
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless curl && \
    rm -rf /var/lib/apt/lists/*

# Download and install Jetty
RUN mkdir -p ${JETTY_HOME}
    curl -SL "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${JETTY_VERSION}/jetty-distribution-${JETTY_VERSION}.tar.gz" | tar -xzC ${JETTY_HOME} --strip-components=1


COPY end_point.txt ${JETTY_HOME}/end_point.txt
RUN ENDPOINT=$(cat ${JETTY_HOME}/end_point.txt)

RUN mkdir /opt/jetty/webapps/ROOT
COPY login.jsp /opt/jetty/demo-base/webapps/ROOT/login.jsp
COPY sign_up.jsp /opt/jetty/demo-base/webapps/ROOT/sign_up.jsp
COPY main.jsp /opt/jetty/demo-base/webapps/ROOT/main.jsp
COPY enroll.jsp /opt/jetty/demo-base/webapps/ROOT/enroll.jsp 
COPY detail.jsp /opt/jetty/demo-base/webapps/ROOT/detail.jsp






RUN apt-get update && \
    apt install dpkg
RUN curl -SL "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j_8.1.0-1ubuntu22.04_all.deb" -o /tmp/mysql-connector-j_8.1.0-1ubuntu22.04_all.deb
    
RUN dpkg -i /tmp/mysql-connector-j_8.1.0-1ubuntu22.04_all.deb

COPY /usr/share/java/mysql-connector-j_8.1.0.jar ${JETTY_HOME}/lib/ext/mysql-connector-j_8.1.0.jar
COPY jdbc-config.xml ${JETTY_HOME}/etc/jdbc-config.xml

# Expose the default Jetty port
EXPOSE 8080

# Set the working directory to Jetty's base directory
WORKDIR ${JETTY_HOME}

# Start Jetty
CMD ["java", "-jar", "start.jar"]
