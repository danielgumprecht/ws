if( -not (Test-Path -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization)){
    New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization
    }
    
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1 -PropertyType DWORD