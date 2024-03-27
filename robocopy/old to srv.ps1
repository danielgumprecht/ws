$srv = Read-Host "enter SRV IP"

### Am alten PC

New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Edge"
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Google"
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Mozilla"

# Edge > SRV
Get-Process -Name msedge -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\Users\$env:USERNAME\AppData\Local\Microsoft\Edge" "\\$srv\clientapps$\_Backups\$env:USERNAME\Edge" /E /MIR /W:0 /V

# Chrome > SRV
Get-Process -Name chrome -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\Users\$env:USERNAME\AppData\Local\Google" "\\$srv\clientapps$\_Backups\$env:USERNAME\Google" /E /MIR /W:0 /V

# Firefox > SRV
Get-Process -Name firefox -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\Users\$env:USERNAME\AppData\Local\Mozilla" "\\$srv\clientapps$\_Backups\$env:USERNAME\Mozilla" /E /MIR /W:0 /V
