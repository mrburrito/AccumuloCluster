#!/bin/bash
#<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">DubsAccumulo Vagrant Cluster</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/wjfrelo/vagrantAccumuloCluster" property="cc:attributionName" rel="cc:attributionURL">Wyatt J. Frelot</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/wjfrelo/vagrantAccumuloCluster" rel="dct:source">https://github.com/wjfrelo/vagrantAccumuloCluster</a>.

echo "localhosts 127.0.0.1
192.168.15.1 hostnode
192.168.15.2 mnode
192.168.15.3 snode1
192.168.15.4 snode2
192.168.15.5 snode3" > /etc/hosts


