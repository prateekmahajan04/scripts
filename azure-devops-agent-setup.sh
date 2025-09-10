#!/bin/bash

# Parameters
ORG_URL=$1
PAT=$2
POOL=$3
AGENT_NAME=$4
AGENT_DIR="/home/azureuser/agent"

sudo apt-get update
sudo apt-get install -y libssl-dev libicu-dev libkrb5-dev curl jq

mkdir -p $AGENT_DIR
cd $AGENT_DIR

curl -O https://vstsagentpackage.azureedge.net/agent/2.220.1/vsts-agent-linux-x64-2.220.1.tar.gz
tar zxvf vsts-agent-linux-x64-2.220.1.tar.gz
rm vsts-agent-linux-x64-2.220.1.tar.gz

export AZP_URL=$ORG_URL
export AZP_TOKEN=$PAT
export AZP_POOL=$POOL
export AZP_AGENT_NAME=$AGENT_NAME

./config.sh --unattended --url $AZP_URL --auth PAT --token $AZP_TOKEN --pool $AZP_POOL --agent $AZP_AGENT_NAME --acceptTeeEula

sudo ./svc.sh install
sudo ./svc.sh start

echo "Azure DevOps Agent setup completed!"
