# Am neuen PC
robocopy "\\192.168.16.99\profile$\$env:USERNAME.V6\AppData\Roaming\Microsoft\Workspaces" "\Users\$env:USERNAME\AppData\Roaming\Microsoft\Workspaces" /E /MIR /W:0 /V
