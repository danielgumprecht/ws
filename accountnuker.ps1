$stamp = Get-Date -Format "yyyyMMdd-HHmmss"

$paths = @(
    "$env:LOCALAPPDATA\Microsoft\OneAuth",
    "$env:LOCALAPPDATA\Microsoft\IdentityCache",
    "$env:LOCALAPPDATA\Microsoft\Office\16.0\Licensing",
    "$env:LOCALAPPDATA\Microsoft\Office\Licenses",
    "$env:LOCALAPPDATA\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\AC\TokenBroker"
)

foreach ($p in $paths) {
    if (Test-Path $p) {
        Rename-Item $p "$p.old-$stamp" -Force
    }
}

Remove-Item "HKCU:\Software\Microsoft\Office\16.0\Common\Identity" -Recurse -Force -ErrorAction SilentlyContinue
