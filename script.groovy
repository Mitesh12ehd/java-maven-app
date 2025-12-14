def buildApp(){
    echo "Building the application"
}

def testApp(){
    echo "Testing the application"
}

def deployApp(){
    echo "Deploying the application ${params.VERSION}"
    // environment variable are available across all the groovy script
}

return this // to import in jenkins file