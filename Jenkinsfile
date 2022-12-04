def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]
pipeline{

    agent any

    environment{
        cluster= "prodCluster"
        service= "prod-svc"
    }
    stages{
        stage('Upload to Prod ECS'){
            steps{
                withAWS(credentials: 'awscreds', region: 'us-east-1'){
                    sh 'aws ecs update-service --cluster ${cluster} --service ${service} --force-new-deployment'
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