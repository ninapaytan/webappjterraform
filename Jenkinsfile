def Public_IP

node {
  stage('terraform') {
    withCredentials([usernamePassword(credentialsId: 'aws-key', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
      sh """
        ls -la
        pwd
        terraform init
        terraform apply --auto-approve
      """
     // inject terraform out to a groovy variable
     dd_ip = sh(returnStdout: true, script: "terraform output Public_IP").trim()
    }
     
     
     
  }
  stage('Testing') {
     sh """
       echo 'Public_IP'
     """
  }

}
