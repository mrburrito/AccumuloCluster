#!/bin/bash

cense" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">DubsAccumulo Vagrant Cluster</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/wjfrelo/vagrantAccumuloCluster" property="cc:attributionName" rel="cc:attributionURL">Wyatt J. Frelot</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/wjfrelo/vagrantAccumuloCluster" rel="dct:source">https://github.com/wjfrelo/vagrantAccumuloCluster</a>.

# This script will perform the following functions:
# (1) Hadoop: Format the Namenode, start up the full cluster for Hadoop
# (2) ZooKeeper: Start a single Quorum for Zookeeper
# (3) Accumulo: Initializes the Accumulo Cluster and starts up Accumulo

hadoop namenode -format
/cloud/hadoop/sbin/./start-all.sh
/cloud/zookeeper/bin/./zkServer.sh start

accumulo init
/cloud/accumulo/bin/./start-all.sh
