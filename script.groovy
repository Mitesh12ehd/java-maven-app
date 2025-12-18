def buildJar(){
    echo "building the application..."
    sh "mvn package"
}

def buildImage(){
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
        sh "docker push miteshch/demo-app:jma-2.0"
    }
}

def deployApp(){
    echo "deploying the application..."
}

return this