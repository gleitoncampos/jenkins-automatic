#!/bin/bash
###############################################################################################################################
############ Adding Groovy script that add an Admin user and set Jenkins state to "SETUP COMLPLETE"   #########################
###############################################################################################################################

if [ ! -d "${JENKINS_HOME}/init.groovy.d" ]; then
  mkdir -p ${JENKINS_HOME}/init.groovy.d
fi
cat > ${JENKINS_HOME}/init.groovy.d/initAdmin.groovy <<_EOF_
#!groovy

import jenkins.model.*
import hudson.security.*
import hudson.util.*;
import jenkins.install.*;

def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
def env = System.getenv()
instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)
hudsonRealm.createAccount("admin", "${JENKINS_ADMIN_PASSWORD}")
instance.setSecurityRealm(hudsonRealm)
instance.save()
_EOF_
