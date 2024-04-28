#!/bin/bash

# set -e // exit when any command fails
# set -x // print each command before executing
# set -o pipefail // exit when any command in a pipe fails
# set -u // exit when using an undefined variable

# exit when any command fails, print each command before executing, exit when using an undefined variable
set -e -x -u 

# set -u // exit when using an undefined variable

# set the output variable release-url to http://example.com
# echo "::set-output name=release-url::http://example.com" 
echo "release-url=http://example.com" >> $GITHUB_OUTPUT
# echo "The release-url is: $GITHUB_OUTPUT"

# exit with a successful status code
exit 0 
