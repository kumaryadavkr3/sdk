pipeline {
    agent any

    environment {
        GOOGLE_CREDENTIALS = credentials('jenkins-appengine')  // Reference to your Google Cloud credentials in Jenkins
        GOOGLE_PROJECT_ID = 'cool-ocean-449307-h8'  // Your GCP project ID
        GOOGLE_REGION     = 'us-central1'  // Region for Cloud Run
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone your Git repository that contains your REST API code
                git 'https://github.com/kumaryadavkr3/rky.git'  // Replace with your repository URL
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    // Initialize Terraform
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Run Terraform plan to see what changes are required
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform plan to deploy the infrastructure
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Test Deployment') {
            steps {
                script {
                    // Use curl to test the REST API endpoint
                    def cloudRunUrl = sh(script: 'terraform output -raw cloud_run_url', returnStdout: true).trim()
                    sh "curl -I ${cloudRunUrl}"  // Test the Cloud Run endpoint
                }
            }
        }
    }

    post {
        always {
            cleanWs()  // Clean up workspace after each build
        }
    }
}
