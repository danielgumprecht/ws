### Am alten PC

New-Item -ItemType Directory -Path "\\192.168.16.99\clientapps$\_Backups\$env:USERNAME\Edge"
New-Item -ItemType Directory -Path "\\192.168.16.99\clientapps$\_Backups\$env:USERNAME\Google"
New-Item -ItemType Directory -Path "\\192.168.16.99\clientapps$\_Backups\$env:USERNAME\Mozilla"

# Edge > SRV
Get-Process -Name msedge -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\Users\$env:USERNAME\AppData\Local\Microsoft\Edge" "\\192.168.16.99\clientapps$\_Backups\$env:USERNAME\Edge" /E /MIR /W:0 /V

# Chrome > SRV
Get-Process -Name chrome -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\Users\$env:USERNAME\AppData\Local\Google" "\\192.168.16.99\clientapps$\_Backups\$env:USERNAME\Google" /E /MIR /W:0 /V

# Firefox > SRV
Get-Process -Name firefox -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\Users\$env:USERNAME\AppData\Local\Mozilla" "\\192.168.16.99\clientapps$\_Backups\$env:USERNAME\Mozilla" /E /MIR /W:0 /V
