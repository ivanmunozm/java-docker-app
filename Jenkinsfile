@Library('shared-library') _
pipeline {
    agent any

    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'choice Action create/delete')
        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'javappspring')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: 'v1')
        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'gusanorock')
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
                    def SonarQubecredentialsId = 'sonar-api'
                     statiCodeAnalysis(SonarQubecredentialsId) 
                }
            }
        }

        stage('Quality Gate Status Check: SonarQube') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    QualityGateStatus('sonar-api')
                }
            }
        }

        stage('Maven Build: maven') {

            when { expression { params.action == 'create' } }

            steps {
                script {
                     mvnBuild() 
                }
            }
        }

        stage('Docker Image Build') {

            when { expression { params.action == 'create' } }

            steps {
                script {
                     dockerbuild("${params.ImageName}", "${params.ImageTag}","params.AppName") 
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
