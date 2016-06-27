#!/bin/bash

# set vault values to disk
vault read -field=value secret/marathon/mesos_framework_auth > /tmp/marathon-mesos-authentication-secret

# set env vars from vault
export MARATHON_ZK=$(vault read -field=value secret/marathon/marathon_zk_connect)
export MARATHON_MASTER=$(vault read -field=value secret/marathon/marathon_mesos)

# pack docker auth for marathon
mkdir -p /tmp/docker_auth/.docker
vault read -field=value secret/repositories/docker/auth > /tmp/docker_auth/.docker/config.json
cd /tmp/docker_auth
tar cvzf /tmp/docker.tar.gz .docker

# start service
/usr/bin/marathon
