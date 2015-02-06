#!/bin/bash

#<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">DubsAccumulo Vagrant Cluster</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/wjfrelo/vagrantAccumuloCluster" property="cc:attributionName" rel="cc:attributionURL">Wyatt J. Frelot</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/wjfrelo/vagrantAccumuloCluster" rel="dct:source">https://github.com/wjfrelo/vagrantAccumuloCluster</a>.

# This script will perform the following functions:
# (3) Accumulo: Stops the full cluster for Accumulo.
# (2) ZooKeeper: Stops the single Quorum for Zookeeper
# (1) Hadoop: Stops the full cluster for Hadoop

/cloud/accumulo/bin/./stop-all.sh
/cloud/zookeeper/bin/./zkServer.sh stop
/cloud/hadoop/sbin/./stop-all.sh


