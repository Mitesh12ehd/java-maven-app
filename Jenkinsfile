#!/user/bin/env groovy

// Import library

// identifier: library_name@tag : tag can be branch name or commit hash

library identifier: "jenkins-shared-library@main", 
        retriever: modernSCM([
            $class: "GitSCMSource", 
            remote: "https://github.com/Mitesh12ehd/jenkins-shared-library.git",
            credentialsId: "github-credential"
        ])

pipeline{
    agent any
    tools{
        maven "maven-3.9"
    }
    environment{
        IMAGE_NAME = "miteshch/demo-app:java-maven-1.0"
    }
    stages{
        stage("build jar"){
            steps{
                script{
                    buildJar();
                }
            }
        }
        stage("build image"){
            steps{
                script{
                    buildImage "${IMAGE_NAME}";   
                }
            }
        }
        stage("deploy"){
            steps{
                script{ 
                    echo "Deploying docker image to EC2..."
                    def dockerCommand = "docker compose -f docker-compose.yaml up --detach"
                    sshagent(['ec2-server-key']) {
                        // Print docker compose file into working directory of EC2
                        sh "scp docker-compose.yaml ec2-user@13.201.190.56:/home/ec2-user"
                        // -o flag to avoid popup that ask for yes when we connect using ssh
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.201.190.56 ${dockerCommand}"
                    }
                }
            }
        }
    }
}