pipeline {

  agent {
    label 'centos'
  }
  options {
    timeout(time: 12, unit: 'MINUTES')
    ansiColor('xterm')
  }

  stages {
    stage('Build') {
      steps {
        echo "Building....echo"
        sh 'echo "Building....sh"'
      }
    }
    stage('CloudSploit') {
      steps {
        echo 'Cloudsploit...'
        withCredentials([
          string(credentialsId: 'AQUA_KEY', variable: 'AQUA_KEY'),
          string(credentialsId: 'AQUA_SECRET', variable: 'AQUA_SECRET'),
          string(credentialsId: 'GITHUB_TOKEN', variable: 'GITHUB_TOKEN')
        ]){
          sh '''
            export TRIVY_RUN_AS_PLUGIN=aqua
            export AQUA_URL=https://api.dev.supply-chain.cloud.aquasec.com
            export CSPM_URL=https://stage.api.cloudsploit.com
            trivy fs --security-checks config,vuln,secret .
            # To customize which severities to scan for, add the following flag: --severity UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL
            # To enable SAST scanning, add: --sast
            # To enable npm/dotnet non-lock file scanning, add: --package-json / --dotnet-proj
          '''
        }
      }
    }
    stage('Test') {
      steps {
        echo 'Testing...'
        sh 'sudo docker-compose up --build --exit-code-from pytest'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying.....'
      }
    }
    stage('Build Information.....') {
      steps {
        echo 'BUILD INFORMATION:'
        echo "Build results can be found in here ${BUILD_URL}"
      }
    }
  }
}
