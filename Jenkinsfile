def PowerShell(psCmd) {
    psCmd=psCmd.replaceAll("%", "%%")
    bat "powershell.exe -NonInteractive -ExecutionPolicy Bypass -Command \"\$ErrorActionPreference='Stop';[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$psCmd;EXIT \$global:LastExitCode\""
}

pipeline {

stage('Deploy appliance') {
  steps {
    node('master') {
      sh 'ansible-playbook -v'
    }
    node('windows_node') {
      PowerShell(". '.\\disk-usage.ps1'") 
    }
  }
}
}
