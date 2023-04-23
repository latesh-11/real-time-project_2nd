pipeline{
    agent any

    environment {
        VERSION  = "${env.BUILD_ID}"
    }

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
        stage("docker build & push to nexus"){

            steps{
                 echo "========executing docker build & push to nexus========"
                
                script{
                   withCredentials([string(credentialsId: 'nexus-pass', variable: 'nexus_creds')]) {
                    sh '''
                        docker build -t 192.168.1.8/springapp:${VERSION} .

                        docker login -u admin -p $nexus_creds 192.168.1.8:8083

                        docker push 192.168.1.8/springapp:${VERSION} 

                        docker image rm  -f 192.168.1.8/springapp:${VERSION} 
                        '''
                   }

                }
            }
        }
    }
}