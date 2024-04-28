FROM mcr.microsoft.com/dotnet/core/sdk:3.1

LABEL "com.github.actions.name"="Auto Release Milestone"
LABEL "com.github.actions.description"="Drafts a Github realease based on newly closed milestone"
LABEL version="0.1.0"
LABEL repsityory="https://github.com/lolmeida/auto-release-milestone-with-docker"
LABEL maintainer="Lourenço Almeida "

# Update and Install jq
RUN apt-get update && apt-get install -y jq  

COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
