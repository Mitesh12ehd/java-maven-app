pipeline{
    agent any
    stages{
        stage("test"){
            steps{
                script{
                    echo "Testing the application..."
                }
            }
        }
        stage("build"){
            steps{
                script{
                    echo "Building the application..."
                }
            }
        }   
        stage("deploy") {
            steps {
                script {
                    echo "Deploying the application..."

                    withKubeConfig(
                        credentialsId: "Linode_credential",
                        serverUrl: "https://d5ac8edc-ee9a-4502-a7f1-ddf4e34f102d.ap-west-2-gw.linodelke.net:443"
                    ) {
                        sh "kubectl create deployment nginx-deployment --image=nginx"
                    }
                }
            }
        }
    }
}