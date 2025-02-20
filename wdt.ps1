# Install basic Programs
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "7zip.7zip"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "Google.Chrome"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "Mozilla.Firefox"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "Adobe.Acrobat.Reader.64-bit"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "pdfforge.PDFCreator" 
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "VideoLAN.VLC" 
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "AdoptOpenJDK.OpenJDK.8" 
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "AdoptOpenJDK.OpenJDK.11" 
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "Fortinet.FortiClientVPN" 

# TeamViewerQS to Public Desktop
Start-BitsTransfer -Source "https://customdesignservice.teamviewer.com/download/windows/v15/m4pd3bk/TeamViewerQS.exe" -Destination "C:\Users\Public\Desktop"

# Enable NetFX 3
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3"

# Restart Explorer
Stop-Process -Name "Explorer" -Force
