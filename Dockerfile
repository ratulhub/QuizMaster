FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests -e

FROM tomcat:10.1-jdk17

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Render uses $PORT env var; Tomcat defaults to 8080 if not set
RUN sed -i 's/port="8080"/port="${PORT}"/' /usr/local/tomcat/conf/server.xml
RUN sed -i 's/port="8443"/port="8444"/' /usr/local/tomcat/conf/server.xml

ENV PORT=8080

EXPOSE ${PORT}

CMD ["catalina.sh", "run"]
