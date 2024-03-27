$srv = Read-Host "enter SRV IP"

# Copy User Data
robocopy "\\$srv\RedirectedFolders\$env:USERNAME\Desktop" "\Users\$env:USERNAME\Desktop" /E /W:0 /V
robocopy "\\$srv\RedirectedFolders\$env:USERNAME\Eigene Dateien" "\Users\$env:USERNAME\Eigene Dateien" /E /W:0 /V
robocopy "\\$srv\profile$\$env:USERNAME.V6\Downloads" "\Users\$env:USERNAME\Downloads" /E /W:0 /V

# Copy Edge
Get-Process -Name msedge -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\\$srv\clientapps$\_Browser\$env:USERNAME\Edge" "$env:localappdata\Microsoft\Edge" /E /MIR /W:0 /V

# Copy Chrome
Get-Process -Name chrome -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\\$srv\clientapps$\_Browser\$env:USERNAME\Chrome" "$env:localappdata\Google\Chrome" /E /MIR /W:0 /V

# Copy Firefox
Get-Process -Name firefox -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\\$srv\clientapps$\_Browser\$env:USERNAME\Firefox" "$env:localappdata\Mozilla\Firefox" /E /MIR /W:0 /V
