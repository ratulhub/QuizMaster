FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN echo "=== STEP 1: Maven Version ===" && mvn --version && \
    echo "=== STEP 2: Validating POM ===" && mvn validate -e && \
    echo "=== STEP 3: Resolving Dependencies ===" && mvn dependency:resolve -e && \
    echo "=== STEP 4: Building WAR ===" && mvn clean package -DskipTests -e

FROM tomcat:10.1-jdk17

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Render provides the PORT environment variable at runtime.
# We must replace it in server.xml just before Tomcat starts.
ENV PORT=8080
EXPOSE ${PORT}

CMD sed -i "s/port=\"8080\"/port=\"${PORT}\"/" /usr/local/tomcat/conf/server.xml && \
    sed -i "s/port=\"8443\"/port=\"8444\"/" /usr/local/tomcat/conf/server.xml && \
    catalina.sh run
