### usage
$ cd System01  
$ vagrant ssh-config > sshconfig  
$ knife solo prepare server -F sshconfig  
$ knife solo cook server -F sshconfig  

