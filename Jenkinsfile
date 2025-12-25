#!/user/bin/env groovy

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
                    env.IMAGE_NAME = "${version}-${BUILD_NUMBER}"
                }
            }
        }
        stage("build app"){
            steps{
                script{
                    echo "Building the application..."
                    sh "mvn clean package"
                }
            }
        }
        stage("build image"){
            steps{
                script{
                    echo "Building the docker image..."

                    withCredentials([
                        usernamePassword(
                            credentialsId: 'docker-hub-repo',
                            usernameVariable: 'USER',
                            passwordVariable: 'PASS'
                        )
                    ]){
                        sh "docker build -t miteshch/demo-app:${IMAGE_NAME} ."
                        sh "echo ${PASS} | docker login -u ${USER} --password-stdin"
                        sh "docker push miteshch/demo-app:${IMAGE_NAME}"
                    }
                }
            }
        }
        stage("deploy"){
            steps{
                script{
                    echo "Deploying the application...."
                }
            }
        }

        stage("Commit version update"){
            steps{
                script{
                    withCredentials([
                        usernamePassword(
                            credentialsId: 'github-credential',
                            usernameVariable: 'USER',
                            passwordVariable: 'PASS'
                        )
                    ]){ 
                        // set configuration of user that commit the changes
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'

                        // for printing information
                        sh "git status"
                        sh "git branch"
                        sh "git config --list"

                        // to commit new version
                        sh "git remote set-url origin https://${USER}:${PASS}@github.com/Mitesh12ehd/java-maven-app.git"
                        sh "git add ."
                        sh 'git commit -m "Jenkins: Application version update"'
                        sh "git push origin HEAD:jenkins-practice"
                    }
                }
            }
        }
    }
}