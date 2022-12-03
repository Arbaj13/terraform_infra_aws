FROM openjdk:8 AS BUILD_IMAGE
RUN apt update && apt install maven -y
RUN git clone -b master https://github.com/Arbaj13/terraform_infra_aws.git arbaj-repo
ENV     RELEASE_REPO='arbaj-release' \
        CENTRAL_REPO='arbaj-central' \
        NEXUS_GRP_REPO='arbaj-group' \
        SNAP_REPO='arbaj-snapshot' \
        NEXUSIP='172.31.14.226' \
        NEXUSPORT='8081' \
        NEXUS_USER='admin' \
        NEXUS_PASS='admin' \
        NEXUS_LOGIN='nexuslogin' \
        SONARSCANNER='sonarscanner' \
        SONARSERVER='sonarserver'

RUN cd arbaj-repo && mvn install

FROM tomcat:8-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE /target/Arbaj-V1.war /usr/local/tomcat/webapps/ROOT.war
