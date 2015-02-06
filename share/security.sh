#!/bin/bash

echo "Running post setup script"

sudo ssh-keyscan -t rsa mnode snode1 snode2 snode3 > /etc/ssh/ssh_known_hosts

sudo ssh-keyscan -t dsa mnode snode1 snode2 snode3 >> /etc/ssh/ssh_known_hosts


#cat /vagrant/ps/ssh/mnode.pub > ~/.ssh/authorized_keys
#cat /vagrant/ps/ssh/snode1.pub >> ~/.ssh/authorized_keys
#cat /vagrant/ps/ssh/snode2.pub >> ~/.ssh/authorized_keys
#cat /vagrant/ps/ssh/snode3.pub >> ~/.ssh/authorized_keys

#sudo ssh-keyscan -t rsa mnode snode1 snode2 snode3 > /etc/ssh/ssh_known_hosts

#sudo ssh-keyscan -t dsa mnode snode1 snode2 snode3 >> /etc/ssh/ssh_known_hosts
