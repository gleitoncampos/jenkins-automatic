#!/bin/bash
## Define the variables
#JENKINS_ADMIN_USER=stuard
JENKINS_ADMIN_PASSWORD=
JENKINS_HOME=/var/lib/jenkins
TEST_INSTALL=

### List plugins to be installed. Need to be quoted and separated by commas
PLUGINS='"configuration-as-code","git","git-client","git-server","github","github-api","github-branch-source",'


if [ -z "$JENKINS_ADMIN_PASSWORD" ]; then
  printf "\n######## ADMIN PASSWORD NOT DEFINED ##############"
  printf "\nUsging default password. Don't use in production\n"
  printf "##################################################\n\n"
  JENKINS_ADMIN_PASSWORD="test"
  TEST_INSTALL=true
fi
