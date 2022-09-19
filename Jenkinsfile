pipeline {
  agent { label 'linux'}
  options {
    skipDefaultCheckout(true)
  }

  stages{
    stage('clean workspace') {
      steps {
        cleanWs()
      }
    }
    stage('checkout') {
      steps {
        checkout scm
      }
    }


    stage('terraform') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'aws-key', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
        sh 'ls -la'
        sh 'pwd'
        //sh 'chmod 777 ./terraformw'
        sh 'terraform init'
        sh 'terraform destroy -auto-approve -no-color'
        }
        
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}