# Use the official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables
ENV JETTY_VERSION=9.4.43.v20210629


    

# Install Java and Jetty
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless curl && \
    rm -rf /var/lib/apt/lists/*

# Download and install Jetty
RUN curl -SL "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${JETTY_VERSION}/jetty-distribution-${JETTY_VERSION}.tar.gz" | tar -xzC /home/ubuntu/jetty-distribution-${JETTY_VERSION} --strip-components=1


COPY end_point.txt jetty-distribution-${JETTY_VERSION}/end_point.txt
RUN ENDPOINT=$(cat /home/ubuntu/jetty-distribution-${JETTY_VERSION}/end_point.txt)

RUN mkdir /home/ubuntu/jetty-distribution-${JETTY_VERSION}/webapps/ROOT
COPY login.jsp /home/ubuntu/jetty-distribution-${JETTY_VERSION}/webapps/ROOT/login.jsp
COPY sign_up.jsp /home/ubuntu/jetty-distribution-${JETTY_VERSION}/webapps/ROOT/sign_up.jsp
COPY main.jsp /home/ubuntu/jetty-distribution-${JETTY_VERSION}/webapps/ROOT/main.jsp
COPY enroll.jsp /home/ubuntu/jetty-distribution-${JETTY_VERSION}/webapps/ROOT/enroll.jsp 
COPY detail.jsp /home/ubuntu/jetty-distribution-${JETTY_VERSION}/webapps/ROOT/detail.jsp






RUN apt-get update && \
    apt install dpkg
RUN curl -SL "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j_8.1.0-1ubuntu22.04_all.deb" -o /tmp/mysql-connector-j_8.1.0-1ubuntu22.04_all.deb
    
RUN dpkg -i /tmp/mysql-connector-j_8.1.0-1ubuntu22.04_all.deb

RUN cp /usr/share/java/mysql-connector-j_8.1.0.jar /home/ubuntu/jetty-distribution/${JETTY_VERSION}/lib/ext/mysql-connector-j_8.1.0.jar
COPY jdbc-config.xml /home/ubuntu/jetty-distribution-${JETTY_VERSION}/etc/jdbc-config.xml

# Expose the default Jetty port
EXPOSE 8080

# Set the working directory to Jetty's base directory
WORKDIR /home/ubuntu/jetty-distribution-${JETTY_VERSION}

# Start Jetty
CMD ["java", "-jar", "start.jar"]
