FROM openjdk:8 AS BUILD_IMAGE
RUN apt update && apt install maven -y
RUN git clone -b master https://github.com/Arbaj13/terraform_infra_aws.git arbaj-repo
ENV NEXUSPORT='8081' 

RUN cd arbaj-repo && mvn install

FROM tomcat:8-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE /arbaj-repo/target/Arbaj-Pathan-V1.war /usr/local/tomcat/webapps/ROOT.war
