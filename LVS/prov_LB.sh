# parameter:
#  $1: IP Address of node

#install rvm
#\curl -sSL https://get.rvm.io | bash -s stable
#source ~/.bash_profile

# install misc.
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
yum install -y ntp
/etc/init.d/ntpd start
chkconfig ntpd on


# install LVS
mypublic_ipaddress="$(ip -family inet -o addr show dev eth2 | awk 'BEGIN { FS="[ /]+" }{ print $4 }')"
yum install -y ipvsadm
#cp -a /etc/sysconfig/network-scripts/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-eth1:0
#sed -i -e "s/^IPADDR=192.168.33.10$/IPADDR=${mypublic_ipaddress}/" /etc/sysconfig/network-scripts/ifcfg-eth1
#sed -i -e "s/^DEVICE=eth1$/DEVICE=eth1:0/" /etc/sysconfig/network-scripts/ifcfg-eth1
#service network restart

# sysctl -w net.ipv4.ip_forward=1
sed -i -e "s/^net.ipv4.ip_forward = 0$/net.ipv4.ip_forward = 1/" /etc/sysctl.conf
sysctl -e -q -p

# clear configuration
ipvsadm -C
# add  virtual-service
ipvsadm -A -t ${mypublic_ipaddress}:80
# add forward-target
ipvsadm -a -t ${mypublic_ipaddress}:80 -r 192.168.33.11:80 -m
ipvsadm -a -t ${mypublic_ipaddress}:80 -r 192.168.33.12:80 -m
# show configuration
ipvsadm -l

# save state persistent
service ipvsadm save
chkconfig ipvsadm on

# done
date > /tmp/provisioned.done
