pipeline{
    agents any  // agents - where to execute
                // agent can be node, executor on node

    // stages is where work happens
    stages{
        stage("build"){
            steps{
                echo "Building application"
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