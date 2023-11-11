pipeline {
    agent any

    stages {
        stage('prepare') {
            environment {
                CGO_ENABLED = "0"
            }
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/master']],
                          doGenerateSubmoduleConfigurations: false,
                          extensions: [],
                          submoduleCfg: [],
                          userRemoteConfigs: [[ url: 'https://github.com/golang/example']]
                          // userRemoteConfigs: [[credentialsId: 'id', url: 'git@hogehoge']]
                ])
            }
        }

        stage('check') {
            steps {
                dir('.') {
                    sh 'make lint'
                }
            }
        }

        stage('build') {
            steps {
                sh 'make'
            }
        }

        stage('test') {
            steps {
                sh 'make test'
            }
        }
    }

    post {
        // always {
        //     // TODO: Write something.
        // }
        success {
            archiveArtifacts artifacts: 'sample', fingerprint: true
        }
        //失敗時
        // failure {
        //     // TODO: Write something.
        // }
    }
}
