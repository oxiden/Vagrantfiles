#install rvm
#\curl -sSL https://get.rvm.io | bash -s stable
#source ~/.bash_profile

# install misc.
sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
sudo yum install -y ntp
sudo /etc/init.d/ntpd start
sudo /sbin/chkconfig ntpd on

# install cassandra
sudo rpm -ivh /vagrant/jre-7u67-linux-x64.rpm
sudo tar xz -C /usr/local -f /vagrant/apache-cassandra-1.2.11-bin.tar.gz
sudo ln -s /usr/local/apache-cassandra-1.2.11 /usr/local/cassandra
# java -version
sudo cp /vagrant/cassandra /etc/init.d/cassandra
sudo chmod 755 /etc/init.d/cassandra
# => The stack size specified is too small, Specify at least 228k
sudo sed -i -e 's/JVM_OPTS -Xss[0-9]\+[km]/JVM_OPTS -Xss256k/g' /usr/local/cassandra/conf/cassandra-env.sh
# => Error: Exception thrown by the agent : java.net.MalformedURLException: Local host name unknown: java.net.UnknownHostException: vagrant-centos65.vagrantup.com: vagrant-centos65.vagrantup.com# sed -e /etc/sysconfig/local
sudo sh -c 'echo "127.0.0.1   $(hostname)" >> /etc/hosts'

# start cassandra
sudo chkconfig --add cassandra
#sudo service cassandra start

# done
touch /tmp/provisioned.done
