# gd2-testing
Just some scripts I wrote to automate setting up gd2 in a test env. Haven't put *much* thought into generalizing yet.
It was made with a brand new centos vm in mind, and **many things are centos specific** (like the glusterfs nightly repos)



## First run the `setup_gd2.bash` file on each of your 3 nodes [possibly more]:
`bash --verbose setup_gd2.bash <hostname>`

or

`bash --verbose setup_gd2.bash <hostname> <password>` (this sets up passwordless ssh using sshpass)

It does the following things:
  - Install tmux
  - Copy over a .bashrc that sets GOPATH
  - Copy over `remote_scripts/*.bash` scripts to be run on the remote machine
  - Run setup_gd2_node_master.bash on the remote machine in a tmux session called `setup` which:
    - Downloads Go
    - Downloads, builds, ands installs gd2, installs packages
    - etc
  - Connects you to that tmux session so you can watch the fireworks
  


## Then go to the `ansible/` directory and run the ansible play [latest should work,but is untested]:

`ansible -i inventory.yml etcd.yml`


## Example inventory.yml:

```yml
ghosts:
  hosts:
    g1:
      host1.example.com:
    g3:
      host2.example.com:

  children:
    etcd:
      hosts:
        g2:
          host3.example.com:

```


