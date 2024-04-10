$srv = Read-Host "enter Server IP"

# Am neuen PC
robocopy "\\$srv\profile$\$env:USERNAME.V6\AppData\Roaming\Microsoft\Workspaces" "\Users\$env:USERNAME\AppData\Roaming\Microsoft\Workspaces" /E /MIR /W:0 /V
