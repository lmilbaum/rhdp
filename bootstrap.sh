#!/usr/bin/env bash

if [ $1 == 'start' ]; then
  docker image pull jenkins/jenkins:lts
  docker build -f Dockerfile.jenkins -t rhdp/jenkins .
  docker image pull mysql:5.7
  docker build -f Dockerfile.sonarqube -t rhdp/mysql_sonarqube .
  docker image pull sonarqube:6.7.5
  docker network create rhdp

  docker run \
    --detach \
    --name mysql \
    -p 3306:3306 \
    --env MYSQL_USERNAME=sonar \
    --env MYSQL_PASSWORD=sonar \
    --env MYSQL_DATABASE=sonar \
    --env MYSQL_ROOT_PASSWORD=sonar \
    --network=rhdp \
    rhdp/mysql_sonarqube

  docker run \
    --detach \
    --name sonarqube \
  	-p 9000:9000 -p 9092:9092 \
  	--env SONARQUBE_JDBC_USERNAME=sonar \
  	--env SONARQUBE_JDBC_PASSWORD=sonar \
  	--env SONARQUBE_JDBC_URL="jdbc:mysql://mysql/sonar?useUnicode=true&characterEncoding=utf8&useSSL=false" \
    --network=rhdp \
  	sonarqube:6.7.5

    docker run \
      --detach \
      --name jenkins \
      -p 8080:8080 \
      --network=rhdp \
      rhdp/jenkins
else
  list=$(docker ps -aq)
  if [ -n "$list" ]; then
    docker stop $list
    docker rm $list
    docker network rm rhdp
  fi
fi
