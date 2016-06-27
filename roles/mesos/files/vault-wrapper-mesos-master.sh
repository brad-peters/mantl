#!/bin/bash

# set vault values to disk
principal=$(vault read -field=value secret/mesos-agent/mesos_follower_principal)
creds=$(vault read -field=value secret/mesos-agent/mesos_follower_secret)

echo $principal " " $creds >> /tmp/mesos-credentials
chmod 600 /tmp/mesos-credentials

mesos_framework_auth=$(vault read -field=value secret/mesos-master/mesos_framework_auth)
IFS=':'
mesos_framework_auth_array=($mesos_framework_auth)
unset IFS

for i in "${mesos_framework_auth_array[@]}"; do
    echo $i >> /tmp/mesos-credentials
done

# set env vars from vault
export MESOS_ZK=$(vault read -field=value secret/mesos-master/mesos_zk)

# start service
/usr/sbin/mesos-master $EXTRA_OPTS
