FROM tomcat:10.1-jdk17

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file to ROOT.war so it serves at /
COPY target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
