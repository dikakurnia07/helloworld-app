pipeline{
    agent any
    environment{
        DOCKER_IMAGE = "helloworld-app"
        DOCKER_TAG = "latest"
        DOCKER_REGISTRY = "dika007"
        K8S_NAMESPACE = "default"
        K8S_DEPLOYMENT = "helloworld-app-deployment"
        GIT_REPO_URL = "https://github.com/dikakurnia07/helloworld-app.git"
    }
    stages{
        stage('Checkout'){
            steps{
                git branch: 'main', url: "$GIT_REPO_URL"
            }
        }
        stage('Build Docker Image'){
            steps{
                script{
                    bat 'powershell docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% .'
                }
            }
        }
        stage('Push Docker Image'){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]){
                        bat 'docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%'
                    }
                    bat 'docker tag %DOCKER_IMAGE%:%DOCKER_TAG% %DOCKER_REGISTRY%/%DOCKER_IMAGE%:%DOCKER_TAG%'
                    bat 'docker push %DOCKER_REGISTRY%/%DOCKER_IMAGE%:%DOCKER_TAG%'
                }
            }
        }
        stage('Deploy to Kubernetes'){
            steps{
                script{
                    bat 'kubectl config set-context docker-desktop --cluster=docker-desktop --user=docker-desktop --namespace=%K8S_NAMESPACE%'
                    bat 'kubectl config use-context docker-desktop'
                    bat 'kubectl apply -f deployment.yaml'
                    bat 'kubectl rollout restart deployment/%K8S_DEPLOYMENT% -n %K8S_NAMESPACE%'
                    bat 'kubectl rollout status deployment/%K8S_DEPLOYMENT% -n %K8S_NAMESPACE%'
                }
            }
        }
    }
}