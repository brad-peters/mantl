#!/bin/bash

# set vault values to disk
principal=$(vault read -field=value secret/mesos-agent/mesos_follower_principal)
creds=$(vault read -field=value secret/mesos-agent/mesos_follower_secret)

echo $principal " " $creds > /tmp/mesos-agent-credential
chmod 600 /tmp/mesos-agent-credential

# pack docker auth for marathon
mkdir -p /tmp/docker_auth/.docker
vault read -field=value secret/repositories/docker/auth > /tmp/docker_auth/.docker/config.json
cd /tmp/docker_auth
tar cvzf /tmp/docker.tar.gz .docker

# set env vars from vault
export MESOS_MASTER=$(vault read -field=value secret/mesos-agent/mesos_zk)

# start service
/usr/sbin/mesos-slave $EXTRA_OPTS
