#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [ -x "$(command -v minishift)" ]; then
    minishift delete --force
    brew cask uninstall minishift
  fi
  brew cask install minishift
# else
#   curl -X GET https://api.github.com/repos/minishift/minishift/releases/latest
fi

minishift start

eval $(minishift oc-env)
oc login -u developer -p developer --insecure-skip-tls-verify=true
oc get -o yaml --export template/jenkins-ephemeral -n openshift | \
  oc process -f - | oc create -f -
oc describe dc/jenkins
