#!/bin/bash

# <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">DubsAccumulo Vagrant Cluster</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/wjfrelo/vagrantAccumuloCluster" property="cc:attributionName" rel="cc:attributionURL">Wyatt J. Frelot</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/wjfrelo/vagrantAccumuloCluster" rel="dct:source">https://github.com/wjfrelo/vagrantAccumuloCluster</a>.

# This script is primarily setup to configure some environmental variables and Hadoop

# Pre-generated public key exist and are already placed in the authorized_keys. To give hostnode access, append the  hostnode's public key to guestNode's authorized_keys file

##############Machine Configurations
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

cat <<EOT>> ~/.bashrc

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
export HADOOP_HOME=/cloud/hadoop
export HADOOP_PREFIX=\$HADOOP_HOME
export PATH=\$PATH:\$HADOOP_HOME/bin
export PATH=\$PATH:\$HADOOP_HOME/sbin
export HADOOP_MAPRED_HOME=\$HADOOP_HOME
export HADOOP_COMMON_HOME=\$HADOOP_HOME
export HADOOP_HDFS_HOME=\$HADOOP_HOME
export YARN_HOME=\$HADOOP_HOME
EOT

source ~/.bashrc

##############Hadoop Configuration

####core-site.xml
sed -i "s/<\/configuration>/ /g" /cloud/hadoop/etc/hadoop/core-site.xml
echo "		<property>
			<name>fs.default.name</name>
			<value>hdfs://192.168.15.2:9000</value>
		</property>
</configuration>" >> /cloud/hadoop/etc/hadoop/core-site.xml | tail --lines=20

####yarn-site.xml

sed -i "s/<\/configuration>/ /g" /cloud/hadoop/etc/hadoop/yarn-site.xml

echo "		<property>
			<name>yarn.nodemanager.aux-services</name>
			<value>mapreduce_shuffle</value>

			<name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
			<value>org.apache.hadoop.mapred.ShuffleHandler</value>
		</property>

	</configuration>" >> /cloud/hadoop/etc/hadoop/yarn-site.xml | tail --lines==18

####mapred-site.xml

mv /cloud/hadoop/etc/hadoop/mapred-site.xml.template /cloud/hadoop/etc/hadoop/mapred-site.xml
sed -i "s/<\/configuration>/ /g" /cloud/hadoop/etc/hadoop/mapred-site.xml

echo "		<property>
			<name>mapreduce.framework.name</name>
			<value>yarn</value> 
		</property>

	</configuration>" >> /cloud/hadoop/etc/hadoop/mapred-site.xml | tail --lines==20

####hdfs-site

sed -i "s/<\/configuration>/ /g" /cloud/hadoop/etc/hadoop/hdfs-site.xml

echo "		<property>
			<name>dfs.replication</name>
			<value>1</value>

			<name>dfs.namenode.name.dir</name>
                	<value>file:/cloud/data/hadoop/namenode</value>

			<name>dfs.datanode.data.dir</name>
                	<value>file:/cloud/data/hadoop/datanode</value>
		</property>

	</configuration>" >> /cloud/hadoop/etc/hadoop/hdfs-site.xml | tail --lines==18

#echo "Yes, Yes, Yes, Yes, Yes, Yes, Yes" | hadoop namenode -format

####hadoop-env.sh
sed -i 's/${JAVA_HOME}/"\/usr\/lib\/jvm\/java-7-openjdk-amd64"/' /cloud/hadoop/etc/hadoop/hadoop-env.sh
#sed -i 's/$#export\ HADOOP_LOG_DIR\=\$\{HADOOP_LOG_DIR\}/\$USER/"\#export\ HADOOP\_LOG\_DIR\=\"\/cloud\/logs\/hadoop\"'

####slaves

echo "snode1
snode2
snode3" > /cloud/hadoop/etc/hadoop/slaves

####Format the Namenode
#/cloud/hadoop/bin/./hadoop namenode -format

#/cloud/hadoop/sbin/./start-all.sh






