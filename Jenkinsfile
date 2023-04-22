pipeline{
    agent any

    stages{
        stage("git checkout"){
            steps{
                echo "========executing git checkout========"

                git branch: 'main', url: 'https://github.com/latesh-11/real-time-project_2nd.git'
            }
        }
        stage("sonar quality analysis"){

            steps{
                 echo "========executing static code analysis========"
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-api-key') {
                    sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
        stage("sonar quality gate status"){

            steps{
                 echo "========executing  Quality gate status========"
                
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api-key'
            }
        }
        
    }
}