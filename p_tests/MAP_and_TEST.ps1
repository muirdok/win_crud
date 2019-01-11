# Some CRUD tests

$user_name = "admin"
$user_password = "Nexenta1!"
$disk_name = "Z:"
$unc_path = "\\10.3.76.29\kek_fs1"
$file_name = "testfile.txt"
$folder_name = "testfolder"

#$user_password = ConvertTo-SecureString -String $user_password -AsPlainText -Force
#$user_credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user_name, $user_password

#Atach disk
#New-PSDrive -Persist -Name $disk_name -PSProvider "FileSystem" -Root $unc_path -Credential $user_credential
#net use $disk_name $unc_path /user:$user_name $user_password
net use $disk_name $unc_path
Start-Sleep -m 500

#Create file and directory
New-Item -Path "$($disk_name)\" -Name $file_name -ItemType "file" -Value "This is a text string for CRUD testing."
New-Item -Path "$($disk_name)\" -Name $folder_name -ItemType "directory"

#Rename file and directory
Rename-Item -Path "$($disk_name)\$($file_name)" -NewName "$($disk_name)\$($file_name)_renamed.txt"
Rename-Item -Path "$($disk_name)\$($folder_name)" -NewName "$($disk_name)\$($folder_name)_renamed"

#Update file and directory
"UPDATED txt FILE" | Set-Content "$($disk_name)\$($file_name)_renamed.txt"
New-Item -Path "$($disk_name)\$($folder_name)_renamed\" -Name $file_name -ItemType "file" -Value "This is a text string for CRUD testing. update direcrory with a file."

#Checking files and directory
Test-Path -Path "$($disk_name)\$($folder_name)_renamed\$($file_name)"
Test-Path -Path "$($disk_name)\$($folder_name)_renamed"
Test-Path -Path "$($disk_name)\$($file_name)_renamed.txt"

#Remove all of them
Remove-Item -Path "$($disk_name)\$($folder_name)_renamed\$($file_name)" -Force
Remove-Item -Path "$($disk_name)\$($folder_name)_renamed" -Force
Remove-Item -Path "$($disk_name)\$($file_name)_renamed.txt" -Force

#Checking files and directory
Test-Path -Path "$($disk_name)\$($folder_name)_renamed\$($file_name)"
Test-Path -Path "$($disk_name)\$($folder_name)_renamed"
Test-Path -Path "$($disk_name)\$($file_name)_renamed.txt"

#Checking block should be here
exit 1

net use /d $disk_name
#Remove-PSDrive -Name $disk_name