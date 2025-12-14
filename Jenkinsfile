pipeline{
    agent any  // agents - where to execute
                // agent can be node, executor on node

    // stages is where work happens

    parameters{
        choice(name: 'VERSION', choices: ['1.1.0', '1.2.0', '1.3.0'], description: '')
        booleanParam(name: 'executeTests', defaultValue: true, description: '')
    }

    // environment{
    //     // credentials is method, github-credential is ID that we have given on Jenkins GUI
    //     SERVER_CREDENTIAL  = credentials('github-credential')
    // }

    stages{
        stage("build"){
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps{
                echo "Building application"
                sh 'echo "Building with $SERVER_CREDENTIAL_USR $SERVER_CREDENTIAL_PSW"'
            } 
        }
        stage("test"){
            steps{
                echo "Testing application"
            }
        }
        stage("deploy"){
            steps{
                echo "Deploying application"
            }
        }
    }
}  