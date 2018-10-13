#!/usr/bin/env bash

if [ $1 == 'start' ]; then

  docker-compose build --force-rm --pull
  docker-compose up --detach

  until $(curl --output /dev/null --silent --head --fail http://localhost:8080); do
      printf '.'
      sleep 5
  done
  crumb=$(curl -u "jenkins:jenkins" 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
  curl -d "script=$(cat ./jenkins/create-job.groovy)" -v --user jenkins:jenkins -H "$crumb" http://localhost:8080/scriptText
  curl -d "script=$(cat ./jenkins/install_expermintal_warnings_plugin.groovy)" -v --user jenkins:jenkins -H "$crumb" http://localhost:8080/scriptText
  until $(curl --output /dev/null --silent --head --fail http://localhost:8080); do
      printf '.'
      sleep 5
  done
  crumb=$(curl -u "jenkins:jenkins" 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
  curl -d "script=$(cat ./jenkins/set_default_updatesite.groovy)" -v --user jenkins:jenkins -H "$crumb" http://localhost:8080/scriptText

else

  docker-compose down

fi
