$srv = Read-Host "enter SRV IP"

# Edge > SRV
Get-Process -Name msedge -ErrorAction SilentlyContinue | Stop-Process -Force
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Edge"
robocopy "$env:localappdata\Microsoft\Edge" "\\$srv\clientapps$\_Backups\$env:USERNAME\Edge" /E /MIR /W:0 /V

# Chrome > SRV
Get-Process -Name chrome -ErrorAction SilentlyContinue | Stop-Process -Force
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Chrome"
robocopy "$env:localappdata\Google\Chrome" "\\$srv\clientapps$\_Backups\$env:USERNAME\Chrome" /E /MIR /W:0 /V

# Firefox > SRV
Get-Process -Name firefox -ErrorAction SilentlyContinue | Stop-Process -Force
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Firefox"
robocopy "$env:localappdata\Mozilla\Firefox" "\\$srv\clientapps$\_Backups\$env:USERNAME\Firefox" /E /MIR /W:0 /V
