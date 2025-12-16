pipeline{
    agent any
    stages{
        stage("test"){
            steps{
                script{
                    echo "Testing the application..."
                    echo "Execution pipeline for branch ${BRANCH_NAME}"
                }
            }
        }
        stage("build"){
            when{
                expression{
                    BRANCH_NAME == "main"
                }
            }
            steps{
                script{
                    echo "Building the application..."
                }
            }
        }
        stage("deploy"){
            steps{
                script{
                    echo "Deploying the application..."
                }
            }
        }
    }
}