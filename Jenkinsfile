 pipeline {   
  agent any

  environment {
        TF_VAR_aws_access_key = credentials('AWS_ACCESS_KEY_ID')
        TF_VAR_aws_secret_key = credentials('AWS_SECRET_ACCESS_KEY')
    }

    parameters {
        
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

     stages {

        stage('Deploy'){  
        
         steps {
            sh "terraform version"
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
