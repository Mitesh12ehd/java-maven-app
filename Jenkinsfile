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
        stage("provision server"){
            environment{
                AWS_ACCESS_KEY_ID = credential("aws_access_key_id")
                AWS_SECRET_ACCESS_KEY = credential("aws_secret_access_key")

                // to provide value of variable in terraform
                TF_VAR_env_prefix = "test"
            }
            steps{
                script{
                    dir("terraform"){
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        EC2_PUBLIC_IP = sh (
                            script: "terraform output ec2-instance-public-ip"
                            returnStdout: true
                        ).trim()
                    }
                }
            }
        }
        stage("deploy"){
            environment{
                DOCKER_CREDS = credential("docker-hub-repo")
                // using this by default we get 
                // DOCKER_CREDS_USR and DOCKER_CREDS_PSW
            }
            steps{
                script{ 
                    // wait to become ec2 instance runninge
                    sleep(time: 90, unit: "SECONDS")
                    echo "Deploying docker image to EC2..."

                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME} ${DOCKER_CREDS_USR} ${DOCKER_CREDS_PSW}"
                    def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"

                    sshagent(['ec2-server-key']) {
                        // Copy docker compose and shell file on EC2
                        sh "scp docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                        sh "scp server-cmds.sh ${ec2Instance}:/home/ec2-user"

                        // -o flag to avoid popup that ask for yes when we connect using ssh
                        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd} "
                    }
                }
            }
        }
    }
}