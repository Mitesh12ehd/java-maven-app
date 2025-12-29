#!usr/bin.env groovy

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
            steps{
                script{ 
                    def dockerCommand = "docker run -p 3080:3080 -d miteshch/demo-app:nodeApp1.0"
                    sshagent(['ec2-server-key']) {
                        // -o flag to avoid popup that ask for yes when we connect using ssh
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.201.190.56 ${dockerCommand}"
                    }
                }
            }
        }
    }
}