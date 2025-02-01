@Library('shared-library') _
pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                gitCheckout (
                    branch: 'master',
                    url: 'https://github.com/ivanmunozm/java-docker-app.git'
                )
                echo 'Checkout..'
            }
        }

        stage('Unit Test maven') {
            steps {
                script {
                     mvnTest() 
                }
                echo 'Testing..'
            }
        }

        stage('Integration Test maven') {
            steps {
                script {
                     mvnIntegrationTest() 
                }
                echo 'Testing..'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
