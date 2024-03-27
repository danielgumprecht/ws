# Prompt the user for the username
$username = Read-Host "Enter the username of the domain user you want to add as an administrator"

# Add the domain user to the local administrators group
Add-LocalGroupMember -Group "Administratoren" -Member $env:USERDNSDOMAIN\$username