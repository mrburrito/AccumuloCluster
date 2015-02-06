#!/bin/bash
#<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">DubsAccumulo Vagrant Cluster</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/wjfrelo/vagrantAccumuloCluster" property="cc:attributionName" rel="cc:attributionURL">Wyatt J. Frelot</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/wjfrelo/vagrantAccumuloCluster" rel="dct:source">https://github.com/wjfrelo/vagrantAccumuloCluster</a>.

mkdir /cloud/data # Directory for cluster data
mkdir /cloud/data/hadoop
mkdir /cloud/data/accumulo
mkdir /cloud/data/zookeeper
mkdir /cloud/data/hadoop/namenode
mkdir /cloud/data/hadoop/datanode
mkdir /cloud/logs # Directory for cluster logs
mkdir /cloud/logs/zookeeper
mkdir /cloud/logs/hadoop
mkdir /cloud/logs/accumulo

tar -xvf /vagrant/hadoop-2.4.1.tar.gz -C /cloud/
tar -xvf /vagrant/accumulo-1.6.1-bin.tar.gz -C /cloud
tar -xvf /vagrant/zookeeper-3.4.6.tar.gz -C /cloud

cd /cloud/

ln -s hadoop-2.4.1 hadoop
ln -s accumulo-1.6.1 accumulo
ln -s zookeeper-3.4.6 zookeeper
