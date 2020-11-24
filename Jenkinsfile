def PowerShell(psCmd) {
    psCmd=psCmd.replaceAll("%", "%%")
    bat "powershell.exe -NonInteractive -ExecutionPolicy Bypass -Command \"\$ErrorActionPreference='Stop';[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$psCmd;EXIT \$global:LastExitCode\""
}
APPALINCE_IP = 'initial_value'

pipeline {
    agent { label 'master' }
    parameters {
        string(name: 'AD_IP_2019', defaultValue: '10.3.69.70', description: 'Windows AD 2019 Server IP')
        string(name: 'AD_NAME_2019', defaultValue: 'nex2019.test', description: 'Windows AD 2019 Domain Name')
        string(name: 'VM_NAME', defaultValue: 'mut_fc_winad', description: 'VM Name for VCenter')

    }
    stages {
      stage('Run ALL Windows AD Tests in parallel') {
            parallel {
              stage('Deploy and configure Appalince to join to 2019 Active Directory') {
                steps {
                  node('master') {
                    deleteDir()
                    git url: 'https://github.com/muirdok/win_crud'
                    dir("${WORKSPACE}") {
                          ansiblePlaybook(
                              playbook: 'ansible/deploy_fc_ad.yml',
                              extraVars: [
                                          config_vm_name: params.VM_NAME + "_" + env.BUILD_NUMBER,
                                          ad_ip: params.AD_IP_2019,
                                          ad_name: params.AD_NAME_2019
                                          ]
                                          )
                                          script {
                                            def FILENAME = params.VM_NAME + "_" + env.BUILD_NUMBER + ".ipv4"
                                            APPALINCE_IP = readFile "ansible/${FILENAME}"
                                            println(FILENAME)
                                            println(APPALINCE_IP)
                                          }
                                        }
                                      }
                                    }
                                  }
       stage('Run CRUD on nex2019.test.win2019.client') {
             steps {
               node('nex2019.test.win2019.client') {
                   deleteDir()
                   git url: 'https://github.com/muirdok/win_crud.git'
                       powershell returnStatus: true, script: """p_tests\\MAP_and_TEST.ps1 -ns_ip ${APPALINCE_IP}"""
                         }
                  }
             }
          }
       }
     }
  }
