#!/user/bin/env groovy

// Import library
// Give same name as we have given in jenkins GUI
@Library("jenkins-shared-library")_
// Put underscore after Library, it tell jenkins to import this library then run further code.
// It is mandatory to put _ in declarative syntax, to put _ after Library


pipeline{
    agent any
    tools{
        maven "maven-3.9"
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
                    buildImage "miteshch/demo-app:jma-3.0";   
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