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

# install cassandra
rpm -iv /vagrant/jre-7u67-linux-x64.rpm
tar xz -C /usr/local -f /vagrant/apache-cassandra-1.2.11-bin.tar.gz
ln -s /usr/local/apache-cassandra-1.2.11 /usr/local/cassandra
\rm -f /usr/local/cassandra/bin/*.bat
# java -version
cp /vagrant/cassandra /etc/init.d/cassandra
chmod 755 /etc/init.d/cassandra
sed -i -e "s/listen_address: localhost/listen_address: $1/" /usr/local/cassandra/conf/cassandra.yaml
sed -i -e "s/rpc_address: localhost/rpc_address: 0.0.0.0/" /usr/local/cassandra/conf/cassandra.yaml
sed -i -e 's/- seeds: "127.0.0.1"/- seeds: "192.168.33.10,192.168.33.11,192.168.33.12"/' /usr/local/cassandra/conf/cassandra.yaml
# => The stack size specified is too small, Specify at least 228k
sed -i -e 's/JVM_OPTS -Xss[0-9]\+[km]/JVM_OPTS -Xss256k/g' /usr/local/cassandra/conf/cassandra-env.sh
# => Error: Exception thrown by the agent : java.net.MalformedURLException: Local host name unknown: java.net.UnknownHostException: vagrant-centos65.vagrantup.com: vagrant-centos65.vagrantup.com
# JNA
#cp /vagrant/{jna-4.1.0.jar,jna-platform-4.1.0.jar} /usr/local/cassandra/lib/
#echo 'root             soft    memlock         unlimited' >> /etc/security/limits.conf
#echo 'root             hard    memlock         unlimited' >> /etc/security/limits.conf
echo "192.168.33.10   db1.localdomain" >> /etc/hosts
echo "192.168.33.11   db2.localdomain" >> /etc/hosts
echo "192.168.33.12   db3.localdomain" >> /etc/hosts
# set fd-limit, etc... #sysctl -w xxxx=yyyyy

# PATH
echo 'export PATH=/usr/local/cassandra/bin:$PATH' >> ~/.bash_profile
echo 'export PATH=/usr/local/cassandra/bin:$PATH' >> ~vagrant/.bash_profile

# start cassandra
chkconfig --add cassandra
#service cassandra start

# done
date > /tmp/provisioned.done
