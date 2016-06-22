#!/bin/bash

# set vault values to disk
vault read -field=mesos_framework_auth secret/marathon/mesos_framework_auth/ > /tmp/marathon-mesos-authentication-secret

# set env vars from vault
export MARATHON_ZK=$(vault read -field=value secret/marathon/marathon_zk_connect)
export MARATHON_MASTER=$(vault read -field=value secret/marathon/marathon_mesos)

# start service
/usr/bin/marathon
