 pipeline {   
  agent any

  environment {
        GIT_URL = "https://github.com/Hong-jj/sesac_project-terraform.git"
        AWS_ACCESS_KEY_ID     = credentials('AWS_Access_ID_Key')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_Secret_ID_Key') 
    }

    parameters {
        
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

     stages {
        
        stage('Pull') {
            steps {
                git url: "${GIT_URL}", branch: "main", poll: true, changelog: true
            }
        }

        stage('Deploy'){  
        
         steps {
            sh "terraform version"
           }
        }

        stage('init') {
            steps {
               sh 'terraform init'
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
