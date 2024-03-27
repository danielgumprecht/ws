# Prompt user to input the username to delete
$username = Read-Host "Enter the username to delete"

# Delete user from registry
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$username" -Force -ErrorAction SilentlyContinue

# Delete user folder
Remove-Item -Path "C:\Users\$username" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "User $username has been deleted."
