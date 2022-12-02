pipeline{
    agent any
    tools{
        maven "Maven3"
        jdk "OracleJDK8"
    }
    environment{
        RELEASE_REPO='arbaj-release'
        CENTRAL_REPO='arbaj-central'
        NEXUS_GRP_REPO= 'arbaj-group'
        SNAP_REPO ='arbaj-snapshot'
        NEXUSIP= '172.31.2.137'
        NEXUSPORT= '8081'
        NEXUS_USER= 'admin'
        NEXUS_PASS= 'admin'
        NEXUS_LOGIN='nexuslogin'
        SONARSCANNER='sonarscanner'
        SONARSERVER='sonarserver'
    }
    stages{
        stage('Build'){
            steps{
                sh 'mvn -s settings.xml -Dskiptests install '
            }
            post{
                success{
                    echo "Now Archiving Artifats"
                    archiveArtifacts artifacts: '**/*.war'

                }

            }

        }
        stage('Test'){
            steps{
                sh 'mvn test'
            }
        }
        stage('Checkstyle Analysis'){
            steps{
                sh 'mvn checkstyle:checkstyle'
            }
        }
        stage('SonarQube Scanner'){
             environment {
                scannerHome = tool "${SONARSCANNER}"
            }
            steps {
               withSonarQubeEnv("${SONARSERVER}") {
                   sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                   -Dsonar.projectName=vprofile \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
              }
            }


        }
    }
}