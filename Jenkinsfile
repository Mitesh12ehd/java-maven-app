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