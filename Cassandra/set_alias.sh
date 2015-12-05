#!/bin/sh
alias d1='vagrant ssh db1'
alias d1s='vagrant ssh db1 -c "sudo /etc/init.d/cassandra start"'
alias d1t='vagrant ssh db1 -c "sudo /etc/init.d/cassandra stop"'
alias d1r='vagrant ssh db1 -c "/usr/local/cassandra/bin/nodetool ring"'

alias d2='vagrant ssh db2'
alias d2s='vagrant ssh db2 -c "sudo /etc/init.d/cassandra start"'
alias d2t='vagrant ssh db2 -c "sudo /etc/init.d/cassandra stop"'
alias d2r='vagrant ssh db2 -c "/usr/local/cassandra/bin/nodetool ring"'

alias d3='vagrant ssh db3'
alias d3s='vagrant ssh db3 -c "sudo /etc/init.d/cassandra start"'
alias d3t='vagrant ssh db3 -c "sudo /etc/init.d/cassandra stop"'
alias d3r='vagrant ssh db3 -c "/usr/local/cassandra/bin/nodetool ring"'
