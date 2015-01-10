#\curl -sSL https://get.rvm.io | bash -s stable
#source ~/.bash_profile
sudo yum install -y ntp
sudo /etc/init.d/ntpd start
sudo /sbin/chkconfig ntpd on
touch /tmp/provisioned.done
