 pipeline {   
  agent any

  environment {
       AWS_CREDENTIALS= "AWS Credentials"
    }

    parameters {
        
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }
        stage('Deploy'){  
        
         steps {
            sh "terraform version"
           }
        }

        stage('init') {
            steps {
             dir ("Project_django_Terraform "){
               sh 'ls -l'
               sh 'terraform init'
             }
            }
        }
      
              stage('plan') {
            steps {
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
