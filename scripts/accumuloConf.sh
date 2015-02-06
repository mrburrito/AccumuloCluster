#!/bin/bash
# <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">DubsAccumulo Vagrant Cluster</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/wjfrelo/vagrantAccumuloCluster" property="cc:attributionName" rel="cc:attributionURL">Wyatt J. Frelot</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/wjfrelo/vagrantAccumuloCluster" rel="dct:source">https://github.com/wjfrelo/vagrantAccumuloCluster</a>.

# This script is primarily setup to configure some environmental variables and Hadoop

# Pre-generated public key exist and are already placed in the authorized_keys. To give hostnode access, append the  hostnode's public key to guestNode's authorized_keys file

##############Machine Configuration

cat <<EOT>> ~/.bashrc
# Accumulo variables

export ACCUMULO_HOME=/cloud/accumulo
export PATH=\$PATH:\$ACCUMULO_HOME/bin
export PATH=\$PATH:\$ACCUMULO_HOME/conf
export ACCUMULO_CONF_HOME=\$ACCUMULO_HOME/conf
EOT

source ~/.bashrc

##############Accumulo Configuration
/cloud/accumulo/bin/./bootstrap_config.sh <<<"1
1
2
"

#####accumulo-env.sh
sed -i 's/\/path\/to\/hadoop/"\/cloud\/hadoop"/' /cloud/accumulo/conf/accumulo-env.sh
sed -i 's/\/path\/to\/zookeeper/"\/cloud\/zookeeper"/' /cloud/accumulo/conf/accumulo-env.sh
sed -i 's/\/path\/to\/java/"\/usr\/lib\/jvm\/java-7-openjdk-amd64"/' /cloud/accumulo/conf/accumulo-env.sh 
sed -i 's/\$ACCUMULO_HOME\/logs/"\/cloud\/logs\/accumulo"/' /cloud/accumulo/conf/accumulo-env.sh

#####accumulo-site.xml
sed -i 's/localhost/mnode/g' /cloud/accumulo/conf/accumulo-site.xml

####monitor
echo "snode2" > /cloud/accumulo/conf/monitor

####garbage collector
echo "snode3" > /cloud/accumulo/conf/gc

####master
echo "mnode" >/cloud/accumulo/conf/masters

####slaves
echo "snode1
snode2
snode3" > /cloud/accumulo/conf/slaves

####tracers
echo  "snode3" > /cloud/accumulo/conf/tracers

####Initialize Accumulo
#/cloud/accumulo/bin/./accumulo init
#/cloud/accumulo/bin/./start-all.sh

