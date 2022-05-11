#!/bin/bash

if [ -n "$PLUGINS" ]; then
  cat > ${JENKINS_HOME}/init.groovy.d/initPlugins.groovy <<_EOF_
  /* Install required plugins and restart Jenkins, if necessary.  */

  import jenkins.*
  import hudson.*
  import com.cloudbees.plugins.credentials.*
  import com.cloudbees.plugins.credentials.common.*
  import com.cloudbees.plugins.credentials.domains.*
  import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
  import hudson.plugins.sshslaves.*;
  import hudson.model.*
  import jenkins.model.*
  import hudson.security.*

  final List<String> REQUIRED_PLUGINS = [${PLUGINS}]

  if (Jenkins.instance.pluginManager.plugins.collect {
        it.shortName
    }.intersect(REQUIRED_PLUGINS).size() != REQUIRED_PLUGINS.size()) {
    REQUIRED_PLUGINS.collect {
        Jenkins.instance.updateCenter.getPlugin(it).deploy()
    }.each {
        it.get()
    }
  }
  def doneFile = new File("${JENKINS_HOME}/done.txt")
  doneFile.delete()
  doneFile.createNewFile()
  doneFile.text="Done!" 
  println "Plugins were installed successfully"
_EOF_
  else
    echo "No Plugins to install. Skiping..."
fi