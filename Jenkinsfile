pipeline {
    agent any

    parameters {
        choice(name: 'TerraformAction', choices: 'Deploy\nDestroy', description: 'Select the action to perform')
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Checkout Terraform code from GitHub
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/main']],
                        userRemoteConfigs: [[url: 'https://github.com/kiran-113/aws-demo-tf-jenkins.git']]
                    ])
                }
            }
        }

        stage('Terraform Init and Plan') {
            when {
                expression {
                    return params.TerraformAction == 'Deploy'
                }
            }
            steps {
                script {
                    // Conditional execution of init and plan stages only when deploying
                    sh 'terraform init'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression {
                    return params.TerraformAction == 'Deploy'
                }
            }
            steps {
                script {
                        
                        // Deploy resources using Terraform
                        sh 'terraform apply -auto-approve tfplan'
                   
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression {
                    return params.TerraformAction == 'Destroy'
                }
            }
            steps {
                script {
                        
                        // Destroy resources using Terraform with the saved plan
                        sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        success {
            script {
                if (params.TerraformAction == 'Deploy') {
                    echo 'Deployment succeeded'
                } else {
                    echo 'Destroy succeeded'
                }
            }
        }
        failure {
            script {
                if (params.TerraformAction == 'Deploy') {
                    echo 'Deployment failed'
                } else {
                    echo 'Destroy failed'
                }
            }
        }
    }
}
