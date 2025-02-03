@Library('shared-library') _
pipeline {
    agent any

    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'choice Action create/delete')
    }

    stages {

        stage('Git Checkout') {
            
            when { expression { params.action == 'create' } }

            steps {
                gitCheckout (
                    branch: 'master',
                    url: 'https://github.com/ivanmunozm/java-docker-app.git'
                )
                echo 'Checkout..'
            }
        }

        stage('Unit Test maven') {

            when { expression { params.action == 'create' } }

            steps {
                script {
                     mvnTest() 
                }
                echo 'Testing..'
            }
        }

        stage('Integration Test maven') {

            when { expression { params.action == 'create' } }

            steps {
                script {
                     mvnIntegrationTest() 
                }
            }
        }

        stage('Static Code Analysis: SonarQube') {

            when { expression { params.action == 'create' } }

            steps {
                script {
                     statiCodeAnalysis() 
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
