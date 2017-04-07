$ErrorActionPreference = "Stop"

If ($env:VSTS_ACCOUNT -eq $null) {
    Write-Error "Missing VSTS_ACCOUNT environment variable"
    exit 1
}

if ($env:VSTS_TOKEN -eq $null) {
    Write-Error "Missing VSTS_TOKEN environment variable"
    exit 1
}

$useragent = 'vsts-windowscontainer'
$creds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($("user:$env:VSTS_TOKEN")))
$encodedAuthValue = "Basic $creds"
$acceptHeaderValue = "application/json;api-version=3.0-preview"
$headers = @{Authorization = $encodedAuthValue;Accept = $acceptHeaderValue }
$vstsUrl = "https://$env:VSTS_ACCOUNT.visualstudio.com/_apis/distributedtask/packages/agent?platform=win7-x64&`$top=1"
$response = Invoke-WebRequest -UseBasicParsing -Headers $headers -Uri $vstsUrl -UserAgent $useragent

$response = ConvertFrom-Json $response.Content

Write-Host "Download agent to C:\BuildAgent\agent.zip"
Invoke-WebRequest -Uri $response.value[0].downloadUrl -OutFile C:\BuildAgent\agent.zip

Write-Host "Extract agent.zip"
Expand-Archive -Path C:\BuildAgent\agent.zip -DestinationPath C:\BuildAgent

Write-Host "Deleting agent.zip"
Remove-Item -Path C:\BuildAgent\agent.zip
