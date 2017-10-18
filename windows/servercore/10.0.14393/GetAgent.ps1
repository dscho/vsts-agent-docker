$ErrorActionPreference = "Stop"

$agentdir = "C:\BuildAgent"

$useragent = 'vsts-windowscontainer'
$acceptHeaderValue = "application/json;api-version=3.0-preview"
$headers = @{Accept = $acceptHeaderValue }
$url = "https://api.github.com/repos/Microsoft/vsts-agent/releases/latest"
$response = Invoke-WebRequest -UseBasicParsing -Headers $headers -Uri $url -UserAgent $useragent

$response = ConvertFrom-Json $response.Content

$url = ""
$response.assets | Foreach-Object { if ($_.name -match "^vsts-agent-win7-x64") { $url = $_.browser_download_url } }

Write-Host "Download agent to $agentdir\agent.zip"
Invoke-WebRequest -Uri $url -OutFile $agentdir\agent.zip

Write-Host "Extract agent.zip"
Expand-Archive -Path $agentdir\agent.zip -DestinationPath $agentdir

Write-Host "Deleting agent.zip"
Remove-Item -Path $agentdir\agent.zip
