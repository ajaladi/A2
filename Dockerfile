FROM tomcat:9.0-jdk15
LABEL maintainer="ajaladi@gmu.edu"
COPY swe645_assn2.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh","run"]