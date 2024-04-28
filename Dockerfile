FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build

LABEL "com.github.actions.name"="Auto Release Milestone"
LABEL "com.github.actions.description"="Drafts a Github realease based on newly closed milestone"
LABEL version="0.1.0"
LABEL repsityory="https://github.com/lolmeida/auto-release-milestone-with-docker"
LABEL maintainer="Lourenço Almeida "

# Update and Install jq
RUN apt-get update && apt-get install -y jq  
# Install GitReleaseManager
RUN dotnet tool install --global GitReleaseManager.Tool  --version 0.13.0-alpha0050

# Add GitReleaseManager to PATH
ENV PATH /root/.dotnet/tools:$PATH  

COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]

