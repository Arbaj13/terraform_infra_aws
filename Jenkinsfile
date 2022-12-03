def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]
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
        NEXUSIP= '172.31.14.226'
        NEXUSPORT= '8081'
        NEXUS_USER= 'admin'
        NEXUS_PASS= 'admin'
        NEXUS_LOGIN='nexuslogin'
        SONARSCANNER='sonarscanner'
        SONARSERVER='sonarserver'
        registryCredential = 'ecr:us-east-1:awscreds'
        appRegistry = '589627010024.dkr.ecr.us-east-1.amazonaws.com/cicd'
        vprofileRegistry = "https://589627010024.dkr.ecr.us-east-1.amazonaws.com"
        cluster= "DevCluster"
        service= "decsvc"
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
         stage("Quality Gates") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage("UploadArtifact"){
            steps{
                nexusArtifactUploader(
                  nexusVersion: 'nexus3',
                  protocol: 'http',
                  nexusUrl: "${NEXUSIP}:${NEXUSPORT}",
                  groupId: 'QA',
                  version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}",
                  repository: "${RELEASE_REPO}",
                  credentialsId: "${NEXUS_LOGIN}",
                  artifacts: [
                    [artifactId: 'Arbaj',
                     classifier: '',
                     file: 'target/Arbaj-V1.war',
                     type: 'war']
                  ]
                )
            }
        }
         stage('Build App Image') {
            steps {
                script {
                    dockerImage = docker.build( appRegistry + ":$BUILD_NUMBER", "./Dockerfile/")
                }
            }
        }
         stage('Upload App Image') {
          steps{
            script {
              docker.withRegistry( vprofileRegistry, registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
              }
            }
          }
        }

    }
     post {
        always {
            echo 'Slack Notifications.'
            slackSend channel: '#cicd',
                color: COLOR_MAP[currentBuild.currentResult],
                message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }

    }
}