#!/bin/bash

# set vault values to disk
vault read -field=mesos_framework_auth secret/marathon/mesos_framework_auth/ > /tmp/marathon-mesos-authentication-secret

# pack docker auth for marathon
mkdir /tmp/docker_auth
vault read -field=auth secret/repositories/docker/auth > /tmp/docker_auth/config.json
tar cvzf /tmp/docker.tar.gz /tmp/docker_auth

# set env vars from vault
export MARATHON_ZK=$(vault read -field=value secret/marathon/marathon_zk_connect)
export MARATHON_MASTER=$(vault read -field=value secret/marathon/marathon_mesos)


# start service
/usr/bin/marathon
