# Description: Dockerfile to build the action
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build

# Metadata
LABEL "com.github.actions.name"="Auto Release Milestone"
LABEL "com.github.actions.description"="Drafts a Github realease based on newly closed milestone"
LABEL version="0.1.0"
LABEL repsityory="https://github.com/lolmeida/auto-release-milestone-with-docker"
LABEL maintainer="Lourenço Almeida "

# Update and Install
RUN apt-get update && apt-get install -y jq                                             # Install jq 
RUN dotnet tool install --global GitReleaseManager.Tool --version 0.13.0-alpha0050      # Install GitReleaseManager
ENV PATH /root/.dotnet/tools:$PATH                                                      # Add GitReleaseManager to PATH

# Copy the entrypoint
COPY entrypoint.sh /

# Run the entrypoint
ENTRYPOINT [ "/entrypoint.sh" ]
