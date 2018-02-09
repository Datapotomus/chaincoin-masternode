
# datapotomus / chaincoin-masternode

This is a more put together version of the chaincoin masternode, based on masternode documentation here:

[https://toaster.chaincoin.org/docs/Setting%20up%20a%20Chaincoin%20Masternode%20-%20draft%20v.04.pdf](https://toaster.chaincoin.org/docs/Setting%20up%20a%20Chaincoin%20Masternode%20-%20draft%20v.04.pdf)
 
The build was taking a ton of time on a one core server, so I took advantage of the docker hub to compile it there.

Also built upon the information here. https://steemit.com/chaincoin/@mrewers/setting-up-a-chaincoin-masternode-in-three-steps

## Requirements
You should be able to run this container on a rather small virtual machine that you can obtain by a hosting company. 
Digital ocean has a 1GB droplet that should be able to run the container successfully.

## Usage
You can use this file as a starting place to set up your masternode. It includes already running the make commands which were frankly a little a annoying to have to run. 

Pull the file

`sudo docker pull datapotomus/chaincoin-masternode`

Start the container detached.

`sudo docker run -d -p 8333:8333 -p 11994:11994 --name masternode -t datapotomus/chaincoin-masternode`

## Configure Masternode
After you have started up the container you will need to go into it, and modify the configuration file as well as pulling your public, and private keys from the chaincoin deamon. 

### Enter your container
`sudo docker exec -it masternode bash`

Modify the starter configuration file located in the following location. I included VIM in the dockerfile to be able to modify it.

`/root/.chaincoin/chaincoin.conf`


Change the two values in the file to values you want to use.
```
rpcuser=CHANGETHISUSER
rpcpassword=CHANGETHISPASSWORD
```

Save your file. Then start up the daemon.

`chaincoind --daemon`

Run the following command to obtain your public key:

`chaincoind getaccountaddress 0`

Run this command to obtain your master private key.

`chaincoind masternode genkey`

Do note that you you will need this key for the next step.

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
