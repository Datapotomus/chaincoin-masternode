
# datapotomus / chaincoin-masternode

This is a more put together version of the chaincoin masternode, based on masternode documentation here:

[https://toaster.chaincoin.org/docs/Setting%20up%20a%20Chaincoin%20Masternode%20-%20draft%20v.04.pdf](https://toaster.chaincoin.org/docs/Setting%20up%20a%20Chaincoin%20Masternode%20-%20draft%20v.04.pdf)
 
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

You should also be able to allow some additional chaincoin ports to allow additional masternodes to run on the same box if you are using mulitple docker containers to map to. Here are some extras if you need them.

```
sudo ufw allow 11996
sudo ufw allow 11997
sudo ufw allow 11998
...
```

## Install Docker

You will need to install docker if you haven't done so already.

```
sudo apt-get install apt-transport-https
sudo apt-get install ca-certificates
sudo apt-get install curl
sudo apt-get install software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu/dists/trusty/stable/"
```
Then do a `docker ps` to check and see if docker is running.


## Usage
You can use this file as a starting place to set up your masternode. It includes already running the make commands which were frankly a little a annoying to have to run. 

Pull the file


`sudo docker pull datapotomus/chaincoin-masternode`


Start the container detached.


`sudo docker run -d -p 8333:8333 -p 11994:11994 --name masternode1 -t datapotomus/chaincoin-masternode`


Still need to figure out if you can run multiple containers without port 8333 attached to them.



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

externalip=[SERVER IP ADDRESS]
bind=[SERVER IP ADDRESS]
masternodeprivkey=[MASTERNODE GENKEY]
masternodeaddr=[SERVER IP ADDRESS]:11994

```
Once again will play with the bind to make sure it works. After you are done save your file.

### Start the daemon

```
docker exec -it masternode_localbuild chaincoind --daemon
```

Then check to make sure it actually started.
```
docker exec -it masternode_localbuild chaincoind getinfo
```



### Enter your container
`sudo docker exec -it masternode bash`

Modify the starter configuration file located in the following location. I included VIM in the dockerfile to be able to modify it.

`/root/.chaincoin/chaincoin.conf`


Change the two values in the file to values you want to use. Please note that the daeamon probably won't start without you changing them. If you are running a server these should be private values you record for later.
```
rpcuser=CHANGETHISUSER
rpcpassword=CHANGETHISPASSWORD
```

Save your file. Then start up the daemon.

`chaincoind --daemon`

See if the daemon is running.

`chaincoind getinfo`

If it isn't please once again make sure you change your user and password.


Run the following command to obtain your public key:

`chaincoind getaccountaddress 0`

Write this key down, and save it for later. You will use that as the address to send your coins.

Run this command to obtain your master private key.

`chaincoind masternode genkey`


Do note that you you will need this key for the next step. Please keep it in a safe place. If you lose access to your VM or the hardware you were running on. You can use this key to recover your account. If you don't have it, and you lose access to your hardware you are screwed.


Stop the deamon.

`chaincoind stop`

Modify the chaincoin.conf file, and add the following values. Making sure to replace the values in the <>.

```
listen=1
maternode=1
masternodeprivkey=<keyobtained_by_running_genkey>
masternodeaddr=<static_ip>:11994
```

Start up the agent

`chaincoind --daemon`


### Checking the Daemon

Sometimes you need to check and make sure the daemon is running correctly.

`chaincoind getinfo`

This command provides a list of transaction information.

`chaincoind listtransactions`



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


Bitcoin: 

```
13HyZ4sTcaKRG2w43VPBTQuUTqcYQU1Ssw
```
Monero:

```
4C5fyTXdXjF1k7WvDAJwxTbuw6G9KBZyWE5Sca2Ysi5Gd9nfryzguXELwsYTCfdf6PakU48whQaQ3f8M9T33JN6a5VSJk1FTXcRJHkCEZa
```
Ethereum:

```
0x08aA6AC2f5877C74d45Fc26e961f0CBB56b2e843
```
