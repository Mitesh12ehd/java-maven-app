pipeline{
    agent any
    stages{
        stage("test"){
            steps{
                script{
                    echo "Testing the application..."
                }
            }
        }
        stage("build"){
            steps{
                script{
                    echo "Building the application..."
                }
            }
        }   
        stage("deploy"){
            environment{
                AWS_ACCESS_KEY_ID = credentials("jenkins_access_key_id")
                AWS_SECRET_ACCESS_KEY = credentials("jenkine_aws_secret_access_key")
            }
            steps{
                script{
                    echo "Deploying the application..."
                    sh "kubectl create deployment nginx-deployment --image=nginx"
                }
            }
        }
    }
}