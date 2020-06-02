FROM hub.c.163.com/library/java:latest
VOLUME /tmp
ADD target/wms10002-v1.0.0.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]