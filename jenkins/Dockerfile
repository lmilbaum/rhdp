FROM jenkins/jenkins:lts

MAINTAINER Liora Milbaum, <lmilbaum@redhat.com>

ENV JENKINS_ADMIN_USER="jenkins" JENKINS_ADMIN_PASS="jenkins"
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Duser.timezone=Asia/Jerusalem -Dorg.jenkinsci.plugins.durabletask.BourneShellScript.HEARTBEAT_CHECK_INTERVAL=300"
ENV SONAR_SERVER_URL="http://sonarqube:9000"
ENV RHDP_SONAR_ENABLED=true

COPY plugins.txt /usr/share/jenkins/ref/
COPY init.groovy.d/ ${JENKINS_HOME}/init.groovy.d/
COPY requirements.txt /var/tmp

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y python-pip
RUN pip install --upgrade pip
RUN pip install -r /var/tmp/requirements.txt

USER jenkins
RUN xargs install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
RUN wget -q -O /var/tmp/sonar-scanner-cli-3.2.0.1227-linux.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip
RUN unzip /var/tmp/sonar-scanner-cli-3.2.0.1227-linux.zip -d /var/tmp
