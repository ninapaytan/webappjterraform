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
        sh './terraformw apply -auto-approve -no-color'
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