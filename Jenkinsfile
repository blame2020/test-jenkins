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

        stage('build') {
            steps {
                dir('hello') {
                    sh 'go build -o hello .'
                }
            }
        }
        // stage('check') {
        //     steps {
        //         dir('.') {
        //             sh 'make lint'
        //         }
        //     }
        // }

        // stage('build') {
        //     steps {
        //         sh 'make'
        //     }
        // }

        // stage('test') {
        //     steps {
        //         sh 'make test'
        //     }
        // }
    }

    post {
        always {
            archiveArtifacts artifacts: '**'
        }
        success {
            archiveArtifacts artifacts: 'hello/hello', fingerprint: true
        }
        //失敗時
        // failure {
        //     // TODO: Write something.
        // }
    }
}
