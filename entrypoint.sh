#!/bin/bash

# set -e // exit when any command fails
# set -x // print each command before executing
# set -o pipefail // exit when any command in a pipe fails
# set -u // exit when using an undefined variable

# exit when any command fails, print each command before executing, exit when using an undefined variable
set -e -x -u 

repo_token=$1 

# check if the event name is milestone
if [  "$GITHUB_EVENT_NAME" != "milestone" ]; then
  echo "::debug::The event name was '$GITHUB_EVENT_NAME'"
  exit 0
fi

# set event_type to the action of the event
event_type=$(jq --raw-output .action $GITHUB_EVENT_PATH)

# check if the event type is closed
if [ "$event_type" != "closed" ]; then
  echo "::debug::The event type was '$event_type'"
  exit 0
fi

# get the milestone title
milestone_name=$(jq --raw-output .milestone.title $GITHUB_EVENT_PATH)

# get the owner and repository from the GITHUB_REPOSITORY environment variable
# the IFS variable is used to split the string into an array
IFS='/' read owner repository <<< "$GITHUB_REPOSITORY" # IFS stands for Internal Field Separator

# create a release using the gitreleasemanager tool
release_url=$(dotnet gitreleasemanager create \
--milestone-title $milestone_name \
--token $repo_token \
--targetcommitish $GITHUB_SHA \
--owner $owner \
--repository $repository)


if [ $? -ne 0 ]; then
  echo "::error::Failed to create the release draft"
  exit 1                                                  # exit with a failure status code
fi


# set the release-url output variable
echo "::set-output name=release-url::$release_url"      # OR echo "release-url=$release_url" >> $GITHUB_OUTPUT

# exit with a success status code
exit 0                                                  # exit with a success status code

