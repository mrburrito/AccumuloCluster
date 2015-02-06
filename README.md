# Up and Running
This repo contains the scripts and files needed in order provision an Accumulo cluster.
Follow these steps in order to get Accumulo Vagrant cluster up and running
```
(1) [ON HOST] Clone repo:(git clone https://github.com/wjfrelo/AccumuloCluster.git) or download the zip file (https://github.com/wjfrelo/AccumuloCluster/archive/master.zip) 
(2) [ON HOST] Download the following files:
  (a) Vagrant box: https://drive.google.com/open?id=0B3j5JFecmkYuZ0RZMmJfbnBVbGs&authuser=0
  (b) Hadoop: Download from my repo: https://drive.google.com/open?id=0B3j5JFecmkYudDh1bWtaY2lNOVU&authuser=0
  (c) Accumulo: Download from my repo: https://drive.google.com/open?id=0B3j5JFecmkYuOGpDZVRVckprbVk&authuser=0
  (d) Zookeeper: Download from my repo: https://drive.google.com/open?id=0B3j5JFecmkYuWlNWSUlxNDMtNEU&authuser=0
(3) [ON HOST] Copy downloaded hadoop, accumulo, and zookeeper downloaded files to the top-level "*.../share*" folder
(4) [ON HOST] Change directory to the top-level folder (cloned folder .../vagrantAccumuloCluster)
(5) [ON HOST] Copy the vagrant box (acluster.box) in the "vms" folder in the top-level directory (e.g., cp ~/Downloads/downloaded.box /vagrantAccumuloCluster/vms)
(6) [ON HOST] Type "vagrant up" to bring up cluster nodes (1.5GB RAM/node)
(7) Place the following in the hosts file:
	- "localhosts 127.0.0.1
	- 192.168.15.1 hostnode
	- 192.168.15.2 mnode
	- 192.168.15.3 snode1
	- 192.168.15.4 snode2
	- 192.168.15.5 snode3"
     On Windows machines: "C:\Windows\System32\Drivers\etc\hosts"
     On Linux machines: "/etc/hosts
(8) [ON HOST] Type "vagrant ssh mnode" to log into master node (mnode)
(9) [IN VAGRANT VM] Type "cd /vagrant"
(10) [IN VAGRANT VM] Type "./security.sh" to update known_hosts file for other nodes
(11) [IN VAGRANT VM] Type "./initCluster.sh" to initialize and start cluster. Please note the cluster names/passwords for Accumulo.
```
# Additional Information

[Vagrant](https://docs.vagrantup.com/v2/) provides many capabilities. But, I use it as a development sandbox to test code, test performance, and teach people how to use the Accumulo stack. 

Currently, this Vagrant Accumulo Cluster meets all of my needs for training and testing. Vagrant allows me greater flexibility in my process, upgrading, and in my opinion has a smaller learning curve than other tools.

The current setup was tested on both Windows and MAC OSx platforms. There are some differences in setup when using a Windows platform. Follow the same procedures to connect to the nodes mentioned below and you should be okay 
By default, this vagrant cluster will spin up 4 total nodes once the “vagrant up” command is run from wherever the “Vagrantfile” is located (should be top-level of download folder). The nodes are:
```
(1)	mnode (192.168.15.2): NameNode, ResourceManager, ZKServer, and Accumulo master is locatd
(2)	snode1 (192.168.15.3): DataNode, NodeManager, Tablet Server, Garbage Collector
(3)	snode2 (192.168.15.4): DataNode, NodeManager, Tablet Server, Monitor
(4)	snode3 (192.168.15.5): DataNode, NodeManager, Tablet Server, Tracer
```
##Cluster Information:
The cluster is an Ubuntu Linux cluster (14.04 LTS) that has all of the Accumulo Cluster requirements pre-loaded.  Hadoop 2.4.1, Zookeeper 3.3.6, and Accumulo 1.6.1 will be installed and configured upon provisioning. A post-script will need to be run in order to complete node preparation for cluster initialization.
##Provisioning Scripts in VAGRANT:
There are two types of “provisioning” scripts that I use in order to make this work:
###Pre-provisioning Scripts:
When the command “vagrant up” is run, the cluster will be pre-provisioned using the scripts located in the Downloaded folder:
```
(1)	scripts/admin.sh: Sets hosts file to work with all nodes
(2)	scripts/oldConf.sh: Creates folders and sets necessary permissions
(3)	scripts/hadoopConf.sh: Installs and configures Hadoop
(4)	scripts/zookeepConf.sh: Installs and configures ZooKeeper
(5)	scripts/accumuloConf.sh: Installs and configures Accumulo
```
###Post-provisioning Scripts:
There are three post-provisioning scripts that we have to run from the nodes (/vagrant/) to allow for security considerations needed in order to run both Vagrant commands and passwordless-ssh between nodes and initialize cluster:
In order to get into the nodes, type “vagrant ssh mnode” (Logs into the mnode)
```
(1)	/vagrant/initCluster.sh: This script both initializes the Cluster, but it starts it up as well. Typically, you will only need use this script whenever, the cluster is first started 
(2)	/vagrant/startCluster.sh: This script starts cluster after it has been initialized
(3)	/vagrant/stopCluster.sh: This script stops the cluster
```
<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">DubsAccumulo Vagrant Cluster</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/wjfrelo/vagrantAccumuloCluster" property="cc:attributionName" rel="cc:attributionURL">Wyatt J. Frelot</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/wjfrelo/vagrantAccumuloCluster" rel="dct:source">https://github.com/wjfrelo/vagrantAccumuloCluster</a>.
