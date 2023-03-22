 pipeline {
     agent any

    environment {
        GIT_URL = "https://github.com/Hong-jj/sesac_project-terraform.git"
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY') 
    }

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

     stages {
        
        stage('Pull') {
            steps {
                git url: "${GIT_URL}", branch: "main", poll: true, changelog: true
            }
        }

        stage('Deploy'){  
        Install Terraform
            sh "wget https://releases.hashicorp.com/terraform/1.4.2/terraform_1.4.2_linux_amd64.zip"
            sh "unzip terraform_1.4.2_linux_amd64.zip"
          //sh "sudo mv terraform /usr/bin/"
            sh "terraform version"
        }

        stage('Plan') {

            steps {
                sh 'terraform init -upgrade'
                sh "terraform validate"
                sh "terraform plan"
            }
        }
        stage('Approval') {
           when {

               not {
                   equals expected: true, actual: params.autoApprove
               }
           }
           
           steps {
               script {
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan')]

               }
           }
       }
        stage('Apply') {
            steps {
                sh "terraform apply --auto-approve"
            }
        }
     }
 }
