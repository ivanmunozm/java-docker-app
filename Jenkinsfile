@Library('shared-library') _
pipeline {
    agent any

    parameters {
        choice(name: 'action', choices: 'create\ndelete', description: 'Choice Action: create/delete')
        string(name: 'ImageName', description: "Name of the Docker build", defaultValue: 'javappspring')
        string(name: 'ImageTag', description: "Tag of the Docker build", defaultValue: 'v1')
        string(name: 'DockerHubUser', description: "Docker Hub Username", defaultValue: 'gusanorock')
    }

    stages {

        stage('Git Checkout') {
            when { expression { params.action == 'create' } }
            steps {
                gitCheckout (
                    branch: 'master',
                    url: 'https://github.com/ivanmunozm/java-docker-app.git'
                )
                echo '✅ Git Checkout completed'
            }
        }

        stage('Unit Test Maven') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    mvnTest()
                }
                echo '✅ Unit Tests completed'
            }
        }

        stage('Integration Test Maven') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    mvnIntegrationTest()
                }
                echo '✅ Integration Tests completed'
            }
        }

        stage('Static Code Analysis: SonarQube') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    def SonarQubecredentialsId = 'sonar-api'
                    statiCodeAnalysis(SonarQubecredentialsId)
                }
                echo '✅ SonarQube Analysis completed'
            }
        }

        stage('Quality Gate Status Check: SonarQube') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    QualityGateStatus('sonar-api')
                }
                echo '✅ Quality Gate passed'
            }
        }

        stage('Maven Build') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    mvnBuild()
                }
                echo '✅ Maven Build completed'
            }
        }

        stage('Docker Image Build & Push') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    dockerbuild()
                }
                echo '✅ Docker Image built and pushed successfully'
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying application...'
            }
        }
    }
}
