robocopy "\\192.168.16.99\RedirectedFolders\$env:USERNAME\Desktop" "\Users\$env:USERNAME\Desktop" /E /W:0 /V
robocopy "\\192.168.16.99\RedirectedFolders\$env:USERNAME\Eigene Dateien" "\Users\$env:USERNAME\Eigene Dateien" /E /W:0 /V
robocopy "\\192.168.16.99\profile$\$env:USERNAME.V6\Downloads" "\Users\$env:USERNAME\Downloads" /E /W:0 /V