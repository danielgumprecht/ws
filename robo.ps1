New-Item -ItemType Directory -Path "\\srvad\clientapps$\_Backups\$env:COMPUTERNAME"

robocopy "\Users\$env:USERNAME" "\\srvad\clientapps$\_Backups\$env:COMPUTERNAME\$env:USERNAME" /E /MIR /V