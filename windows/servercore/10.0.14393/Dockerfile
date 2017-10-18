FROM microsoft/windowsservercore:latest

RUN mkdir C:\BuildAgent
WORKDIR C:/BuildAgent

COPY ./GetAgent.ps1 ./
RUN ["powershell", "-command", ".\\GetAgent.ps1"]

COPY ./InitializeGitForWindowsSDKs.ps1 ./
RUN ["powershell", "-command", ".\\InitializeGitForWindowsSDKs.ps1"]

COPY ./StartAgent.ps1 ./
CMD ["powershell", "-command", ".\\StartAgent.ps1"]
