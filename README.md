# gd2-testing
Just some scripts I wrote to automate setting up glusterd2 with **external etcd** in a test env. Haven't put *much* thought into generalizing yet.
It was made with a brand new centos vm in mind, and a few **things may be centos specific** (like the glusterfs nightly repos)

## There are 2 Stages (1 script/play each)

- Stage 1: Setup nodes
  - Installing dependencies
  - Downloading and installing gd2 from source
  - Copying over some convenience scripts for running/stopping gd2 in tmux (`remote_scripts/`)
- Stage 2: Deploy
  - Specifying one of the nodes to also run the external etcd
  - Reflecting that in gd2 configuration of all nodes
  - Starting etcd and gd2
  - Add all peers


## Stage 1: run the `setup_gd2.bash` file on each of your 3 nodes [possibly more]:
`bash --verbose setup_gd2.bash <hostname>`

or

`bash --verbose setup_gd2.bash <hostname> <password>` (this sets up passwordless ssh with that host using sshpass)

Note: sometimes setting up passwordless ssh like this fails because the host fingerprint is not in known_hosts. I hadn't realized this because I use the following lines in my ~/.ssh/config for each test VM:
```
Host x.x.x.x some-optional-alias1
        Hostname x.x.x.x
        Port 22
        User root
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null
        LogLevel QUIET
```
  
I use this to setup a gd2 node after a fresh centos install. It eventually sets up a tmux session `setup` and connects you to it so you can watch the fireworks.


## Stage 2: Go to the `ansible/` directory, make an inventory file like the one below, and run the ansible play:

`ansible-playbook -i inventory.yml etcd.yml`

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

## Resources:

GD2 developement guide: https://github.com/gluster/glusterd2/blob/master/doc/development-guide.md

GD2 quickstart guide: https://github.com/gluster/glusterd2/blob/master/doc/quick-start-user-guide.md

ETCD config template lives in: `ansibles/templates/`

