#!/bin/bash
echo "############################################################"
echo "###############   Reading Variables    #####################"
echo "############################################################"
printf "/n/n"

. ./variables.sh

#############################################################


echo "############################################################"
echo "###   Creating the groovy file that add an admin user  #####"
echo "############################################################"
printf "/n/n"

. ./add-admin.sh


echo "############################################################"
echo "##### Creating the groovy file that install plugins   ######"
echo "############################################################"

. ./add-plugins.sh

echo "############################################################"
echo "######## Restarting Jenkins to apply groovy configs ########"
echo "############################################################"
systemctl restart --no-block jenkins 


echo "############################################################"
if [ -n "$PLUGINS" ]; then

  until [ -f ${JENKINS_HOME}/done.txt ]; do
    echo "Waiting installation of plugins..."
    sleep 15
  done
  sleep 15
  echo "Restarting Jenkins to apply plugins..."
  systemctl restart jenkins || sleep 15

  echo "Restarting Jenkins a second time to remove initial wizard msgs"
  systemctl restart jenkins
fi
echo "############################################################"

echo "############################################################"
echo "##################### Finalizando ##########################"
echo "############################################################"


echo "##########  Cleaning unecessary scripts and files ##########"
if [ -d "${JENKINS_HOME}/init.groovy.d/initAdmin.groovy" ]; then
  rm  ${JENKINS_HOME}/init.groovy.d/initAdmin.groovy
fi
if [ -d "${JENKINS_HOME}/init.groovy.d/initPlugins.groovy" ]; then
  rm  ${JENKINS_HOME}/init.groovy.d/initPlugins.groovy
fi
if [ -d "${JENKINS_HOME}/done.txt" ]; then
  rm  ${JENKINS_HOME}/done.txt
fi
rm -Rf /jenkins-scripts
