#!/usr/bin/env bash

minishift delete --force
brew cask uninstall minishift
brew cask install minishift

minishift start

eval $(minishift oc-env)
oc login -u developer -p developer --insecure-skip-tls-verify=true
oc get -o yaml --export template/jenkins-ephemeral -n openshift | oc create -f -
