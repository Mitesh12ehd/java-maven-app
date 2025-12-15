pipeline{
    agent any
    tools{
        maven "maven-3.9"
    }
    stages{
        stage("build jar"){
            steps{
                    script{
                        echo "building the application..."
                        sh "mvn package"
                    }
            }
        }
        stage("build image"){
            steps{
                    script{
                        echo "building the docker image..."
                        // extract username and password from credential that we have added in GUI
                        withCredentials([
                            usernamePassword(
                                credentialsId: 'docker-hub-repo',
                                usernameVariable: 'USER',
                                passwordVariable: 'PASS'
                            )
                        ]){
                            // inside this block we have access to USER and PASS variable

                            // build image
                            sh "docker build -t miteshch/demo-app:jma-2.0 ."

                            // login into docker, taking password from input as it become masked
                            sh "echo ${PASS} | docker login -u ${USER} --password-stdin"

                            // push image
                            sh "docker push miteshch/java-maven-app:2.0"
                        }
                    }
            }
        }
        stage("deploy"){
            steps{
                script{
                    echo "deploying the application..."
                }
            }
        }
    }
}