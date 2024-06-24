pipeline {
    agent any
 
    environment {
        // Assuming '0007' is the ID of the stored secret file
        GCP_CREDENTIALS = credentials('0007')
    }
 
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/zookeeper00/GCP_Cloudbuild.git', branch: 'main', credentialsId: '2026'
            }
        }
 
        stage('Terraform Init') {
            steps {
                script {
                    // Write the GCP credentials to a file that Terraform can use
                    writeFile file: 'gcp_credentials.json', text: GCP_CREDENTIALS
                    sh 'terraform init'
                }
            }
        }
 
        stage('Terraform Plan') {
            steps {
                script {
                    withEnv(["GOOGLE_CLOUD_KEYFILE_JSON=gcp_credentials.json"]) {
                        sh 'terraform plan -var="gcp_credentials_file=gcp_credentials.json" -out=tfplan'
                    }
                }
            }
        }
 
        stage('Terraform apply') {
            steps {
                script {
                    withEnv(["GOOGLE_CLOUD_KEYFILE_JSON=gcp_credentials.json"]) {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }
    }
 
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Terraform infrastructure has been successfully applied.'
        }
        failure {
            echo 'The build failed.'
        }
    }
}
