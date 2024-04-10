$srv = Read-Host "enter Server IP"

New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Desktop"
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Documents"
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Downloads"
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Favorites"
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Links"
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Music"
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Pictures"
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Videos"
New-Item -ItemType Directory -Path "\\$srv\clientapps$\_Backups\$env:USERNAME\Eigene Dateien"

# Copy User Data
robocopy "$env:userprofile\Desktop" "\\$srv\clientapps$\_Backups\$env:USERNAME\Desktop" /E /MIR /W:0 /V
robocopy "$env:userprofile\Documents" "\\$srv\clientapps$\_Backups\$env:USERNAME\Documents" /E /MIR /W:0 /V
robocopy "$env:userprofile\Downloads" "\\$srv\clientapps$\_Backups\$env:USERNAME\Downloads" /E /MIR /W:0 /V
robocopy "$env:userprofile\Favorites" "\\$srv\clientapps$\_Backups\$env:USERNAME\Favorites" /E /MIR /W:0 /V
robocopy "$env:userprofile\Links" "\\$srv\clientapps$\_Backups\$env:USERNAME\Links" /E /MIR /W:0 /V
robocopy "$env:userprofile\Music" "\\$srv\clientapps$\_Backups\$env:USERNAME\Music" /E /MIR /W:0 /V
robocopy "$env:userprofile\Pictures" "\\$srv\clientapps$\_Backups\$env:USERNAME\Pictures" /E /MIR /W:0 /V
robocopy "$env:userprofile\Videos" "\\$srv\clientapps$\_Backups\$env:USERNAME\Videos" /E /MIR /W:0 /V
robocopy "$env:userprofile\Eigene Dateien" "\\$srv\clientapps$\_Backups\$env:USERNAME\Eigene Dateien" /E /MIR /W:0 /V
