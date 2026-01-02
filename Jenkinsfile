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
    stages{
        stage("increment version"){
            steps{
                script{
                    echo "Incrementing app version"
                    sh "mvn build-helper:parse-version versions:set -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} versions:commit"
                    
                    // Store version in IMAGE_NAME variable
                    def matcher = readFile("pom.xml") =~ "<version>(.+)</version>"

                    // matcher[0] is first full match
                    // matcher[0][1] is value inside (.+)
                    def version = matcher[0][1]

                    // BUILD_NUMBER variable is provide by jenkins, appending it to make unique image name each time
                    env.IMAGE_NAME = "miteshch/demo-app:${version}-${BUILD_NUMBER}"
                }
            }
        }
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
                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}"
                    sshagent(['ec2-server-key']) {
                        // Copy docker compose and shell file on EC2
                        sh "scp docker-compose.yaml ec2-user@13.201.190.56:/home/ec2-user"
                        sh "scp server-cmds.sh ec2-user@13.201.190.56:/home/ec2-user"

                        // -o flag to avoid popup that ask for yes when we connect using ssh
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.201.190.56 ${shellCmd} "
                    }
                }
            }
        }
    }
}