def Public_IP

node {
  stage('terraform') {
    withCredentials([usernamePassword(credentialsId: 'aws-key', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
      sh """
        git clone https://github.com/ninapaytan/webappjterraform.git
        cd /var/lib/jenkins/workspace/terraform-test-adolfo/webappjterraform/
        ls -la
        pwd
        terraform init
        terraform apply --auto-approve
      """
     // inject terraform out to a groovy variable
     Public_IP = sh(returnStdout: true, script: "terraform output Public_IP").trim()
    }
     
     
     
  }
  stage('Testing') {
     sh """
       echo "My variable is ${Public_IP}
     """
  }

}
