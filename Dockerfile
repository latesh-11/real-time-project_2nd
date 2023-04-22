FROM maven as build 
WORKDIR /app
COPY . .
RUN mvn install 

#----------stage 2nd----------#

FROM openjdk:11.0
WORKDIR /app
COPY --from=build app/target/devops-integration.jar /app/
EXPOSE 8083
CMD [ "java" , "-jar" , "devops-integration.jar" ]