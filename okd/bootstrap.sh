#!/bin/bash

command=$1

if [ "$command" = "start" ]; then
	docker build -t rhdp/ubuntu .
#	docker run -it --privileged -v /var/run/libvirt:/var/run/libvirt rhdp/libvirt
else
	docker rm $(docker ps -aq)
	docker rmi $(docker images -q)
fi

# eval $(minishift oc-env)
#
# if [ "$command" = "start" ]; then
# 	oc login -u developer -p developer https://192.168.42.191:8443
# 	oc get projects/ember-csi > /dev/null 2>&1
# 	if [ "$?" == "1" ]; then
# 		oc new-project ember-csi
# 	fi
# 	oc new-app kubevirt/libvirt:latest
# else
# 	oc login -u developer -p developer https://192.168.42.191:8443
# 	oc delete project ember-csi
# fi
