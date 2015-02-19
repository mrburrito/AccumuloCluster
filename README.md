# Up and Running

This repo contains the scripts and files needed in order provision an Accumulo cluster.
Follow these steps in order to get Accumulo Vagrant cluster up and running.

*Note: Windows requires additional configuration for the `vagrant ssh` command to work. See this
[article](http://www.robertpate.net/blog/2013/getting-the-vagrant-ssh-command-to-work-on-windows/) for more information.*


1.  Clone repo [https://github.com/wjfrelo/AccumuloCluster.git](https://github.com/wjfrelo/AccumuloCluster.git) or
	download the [zip file](https://github.com/wjfrelo/AccumuloCluster/archive/master.zip)
   
	````
	<host>$ git clone https://github.com/wjfrelo/AccumuloCluster.git
	```
	
2. 	Ensure [VirtualBox](https://virtualbox.org) is downloaded and installed. The Vagrant setup works with VirtualBox
	out of the box.

3. 	Download the following files from my Google Drive:
	*	[Vagrant Box](https://docs.google.com/uc?id=0B3j5JFecmkYuZ0RZMmJfbnBVbGs&export=download)
	*	[Hadoop](https://docs.google.com/uc?id=0B3j5JFecmkYudDh1bWtaY2lNOVU&export=download)
	*	[Accumulo](https://docs.google.com/uc?id=0B3j5JFecmkYuOGpDZVRVckprbVk&export=download)
	*	[Zookeeper](https://docs.google.com/uc?id=0B3j5JFecmkYuWlNWSUlxNDMtNEU&export=download)

4.	Copy or move the downloaded Hadoop, Accumulo and Zookeeper files to the `AccumuloCluster/share` folder.

5.	Create the directory `AccumuloCluster/vms` and move the downloaded Vagrant Box (`accumuloCluster.box`) to that directory.

6.	Initialize the cluster nodes (1.5GB RAM/node)

	```
	<host>$ vagrant up
	```

7.	Add the following entries to the hosts file (Windows: `C:\Windows\System32\Drivers\etc\hosts`, Linux/OS X: `/etc/hosts`)

	```
	192.168.15.1 hostnode
	192.168.15.2 mnode
	192.168.15.3 snode1
	192.168.15.4 snode2
	192.168.15.5 snode3
	```

8.	Log into the master node (mnode) and execute the following commands:

	```
	<host>$ vagrant ssh mnode	
	
 	# Commands below issued on mnode VM
	<mnode>$ cd /vagrant
	# Updates known_hosts file for other nodes
	<mnode>$ sudo ./security.sh
	# Initializes and starts cluster. Please note the cluster names/passwords for Accumulo.
	<mnode>$ ./initCluster.sh
	```

# Additional Information

[Vagrant](https://docs.vagrantup.com/v2/) provides many capabilities. But, I use it as a development sandbox to test code, test performance, and teach people how to use the Accumulo stack. 

Currently, this Vagrant Accumulo Cluster meets all of my needs for training and testing. Vagrant allows me greater flexibility in my process, upgrading, and in my opinion has a smaller learning curve than other tools.

The current setup was tested on both Windows and MAC OSx platforms. There are some differences in setup when using a Windows platform. Follow the same procedures to connect to the nodes mentioned below and you should be okay 
By default, this vagrant cluster will spin up 4 total nodes once the “vagrant up” command is run from wherever the “Vagrantfile” is located (should be top-level of download folder). The nodes are:

1.	`mnode (192.168.15.2)`: NameNode, ResourceManager, ZKServer, Accumulo Master
2.	`snode1 (192.168.15.3)`: DataNode, NodeManager, Tablet Server, Garbage Collector
3.	`snode2 (192.168.15.4)`: DataNode, NodeManager, Tablet Server, Monitor
4.	`snode3 (192.168.15.5)`: DataNode, NodeManager, Tablet Server, Tracer

## Cluster Information

The cluster is an Ubuntu Linux cluster (14.04 LTS) that has all of the Accumulo Cluster requirements pre-loaded.  Hadoop 2.4.1, Zookeeper 3.3.6, and Accumulo 1.6.1 will be installed and configured upon provisioning. A post-script will need to be run in order to complete node preparation for cluster initialization.

## Vagrant Provisioning Scripts

There are two types of “provisioning” scripts that I use in order to make this work:

### Pre-provisioning Scripts

When the command “vagrant up” is run, the cluster will be pre-provisioned using the scripts located in the `AccumuloCluster/scripts` folder:

1.	`admin.sh`: Sets hosts file to work with all nodes
2.	`oldConf.sh`: Creates folders and sets necessary permissions
3.	`hadoopConf.sh`: Installs and configures Hadoop
4.	`zookeepConf.sh`: Installs and configures ZooKeeper
5.	`accumuloConf.sh`: Installs and configures Accumulo

### Post-provisioning Scripts

There are three post-provisioning scripts that need to be run on the nodes to allow passwordless ssh between nodes and initialize the Accumulo cluster. These
scripts are found in the `AccumuloCluster/share` directory and will be mounted on the VMs at `/vagrant`. These scripts should all be run from the master node
(`mnode`).

1.	`initCluster.sh`: This script both initializes and starts the cluster. Typically, this will only be needed when the cluster is first created.
2.	`startCluster.sh`: This script starts the cluster after it has been initialized.
3.	`stopCluster.sh`: This script stops the cluster.

## Useful Commands

Controlling Vagrant (from host machine):

*	`vagrant up`: Starts the Vagrant VMs if they are not already running. Once they have started, run `/vagrant/startCluster.sh` from the `mnode` to start Accumulo.
*	`vagrant ssh mnode`: Logs into the Master Node. All cluster control scripts should be run from this node.
*	`vagrant halt`: Gently stops the Vagrant VMs. **WARNING: You must run `/vagrant/stopCluster.sh` from the `mnode` prior to using this command.
*	`vagrant destroy`: Destroy the entire cluster and kill any related processes. The cluster can be recreated by following the instructions above.

Controlling the Accumulo Cluster (from `mnode`):

*	`/vagrant/startCluster.sh`: Starts the Accumulo cluster without re-initializing it.
*	`/vagrant/stopCluster.sh`: Stops the Accumulo cluster. Run this before running `vagrant halt` on the host machine.

---

[![Creative Commons License](https://i.creativecommons.org/l/by-nc/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc/4.0/)

Accumulo Vagrant Cluster by [Wyatt J. Frelot](https://github.com/wjfrelo) is licensed under a
[Creative Commons Attribution-NonCommercial 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/).  
Based on a work at [https://github.com/wjfrelot/AccumuloCluster](https://github.com/wjfrelo/AccumuloCluster).
