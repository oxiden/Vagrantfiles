# parameter:
#  $1: IP Address of node
#  $2: Node Identifier

#install rvm
#\curl -sSL https://get.rvm.io | bash -s stable
#source ~/.bash_profile

# install misc.
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
yum install -y ntp
/etc/init.d/ntpd start
chkconfig ntpd on

# install httpd
yum install -y httpd
echo "this is $2" > /var/www/html/index.html
service httpd restart
chkconfig httpd on

# default gateway
route add default gw 192.168.33.10

# done
date > /tmp/provisioned.done
