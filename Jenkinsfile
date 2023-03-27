 pipeline {   
  agent any

  environment {
        TF_VAR_aws_access_key = credentials('aws_access_key_id')
        TF_VAR_aws_secret_key = credentials('aws_secret_access_key')

    }

    parameters {
        
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

     stages {

        stage('Deploy'){  
        
         steps {
            sh "terraform version"
            sh "env"
           }
        }

        stage('init') {
            steps {
             dir ('Project_django_Terraform'){
               sh 'pwd'
               sh 'ls -l'
               sh 'terraform init'
             }
            }
        }
      
              stage('plan') {
            steps {
             dir ('Project_django_Terraform'){
                sh "terraform plan"
             }
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
//              withAWS(credentials: 'AWS_Credentials', region: 'ap-northeast-1'){
              dir('Project_django_Terraform'){
                sh "terraform apply --auto-approve"
              }
//              }
            }
        }
     }
 }
