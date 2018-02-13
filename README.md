
# datapotomus / chaincoin-masternode

This is a more put together version of the chaincoin masternode, based on masternode documentation here:

[https://steemit.com/masternode/@fredyendesigns/chaincoin-remote-controller-masternode-setup-guide](https://steemit.com/masternode/@fredyendesigns/chaincoin-remote-controller-masternode-setup-guide)

You will need to follow parts of their guide in order to get your local wallet set up to manage your master nodes.

 
The build was taking a ton of time on a one core server, so I took advantage of the docker hub to compile it there.

Also built upon the information here. https://steemit.com/chaincoin/@mrewers/setting-up-a-chaincoin-masternode-in-three-steps

## Requirements
You should be able to run this container on a rather small virtual machine that you can obtain by a hosting company. 
Digital ocean has a 1GB droplet that should be able to run the container successfully.


## Prereqs
### Set the Firewall

Run the following commands to allow communication through your ports.

```
sudo ufw allow OpenSSH
sudo ufw allow 8333
sudo ufw allow 11994
sudo ufw allow 2376
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
```


## Install Docker

You will need to install docker if you haven't done so already.
Guide here: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04
I'm pulling out the commands though. Please read the guide if you need more info.

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo systemctl status docker
```

Or, if you are running a more recent OS version like Ubuntu 17.10.

```
sudo apt install docker.io
```


Then do a `docker ps` to check and see if docker is running.


## Usage
You can use this file as a starting place to set up your masternode. It includes already running the make commands which were frankly a little a annoying to have to run. 

Start the container detached.


`sudo docker run -d -p <ip address>:8333:8333 -p <ip address>:11994:11994 --name masternode1 -t datapotomus/chaincoin-masternode`

## Configure Masternode

Modify the template configuration file.

`docker exec -it masternode1 vim /root/.chaincoin/chaincoin.conf`

or

`docker exec -it masternode1 nano /root/.chaincoin/chaincoin.conf`


I included both VIM and nano.  I am partial to VIM, but that's just me.

Modify these parameters that are in the file with your values.

```
rpcuser=XXXXXXXXXXXX
rpcpassword=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

masternodeprivkey=[MASTERNODE GENKEY]
masternodeaddr=[SERVER IP ADDRESS]:11994

```
It doesn't currently appear that the bind is actually needed. Since docker doesn't like it. I think we will skip it.


### Start the daemon

```
docker exec -it masternode1 chaincoind --daemon
```

Then check to make sure it actually started. Give it thrity seconds or so to see if you start getting a status back.
```
docker exec -it masternode1 chaincoind getinfo
```

If you don't you might need to go into your container, and attempt to run it manually.

### Enter your container
`sudo docker exec -it masternode1 bash`

Attempt to start the daemon while you are inside the container if you are having issues, and see if you get an error.

### Checking the Daemon

Sometimes you need to check and make sure the daemon is running correctly.

`chaincoind getinfo`

This command provides a list of transaction information.

`chaincoind listtransactions`

### Start the masternode

Go back into your GUI wallet, and start the masternode on the masternodes tab.



## Troubleshooting

### Firewall
If your masternode can't connect you will need to make sure that your firewall ports are open on your host server running the docker container.
```
sudo ufw allow OpenSSH
sudo ufw allow 8333
sudo ufw allow 11994
sudo ufw allow 2376
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
```

##### Donations
Never expected but always welcome:


Following, and liking my stuff on steemit doesn't cost you anything. :)

https://steemit.com/@datapotomus


Chaincoin
```
CPcz7oWAZTYBgR2JUrfF52HYM4Q6tGhJKd
```
Monero:

```
4C5fyTXdXjF1k7WvDAJwxTbuw6G9KBZyWE5Sca2Ysi5Gd9nfryzguXELwsYTCfdf6PakU48whQaQ3f8M9T33JN6a5VSJk1FTXcRJHkCEZa
```
Ethereum:

```
0x08aA6AC2f5877C74d45Fc26e961f0CBB56b2e843
```
