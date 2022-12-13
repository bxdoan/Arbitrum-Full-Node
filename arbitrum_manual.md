# Update your server and install Docker.

```
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io -y
```

# Open Arbitrum file and give permission.

```
mkdir -p ~/data/arbitrum
chmod -fR 777 ~/data/arbitrum
```

# Run your node. Don't forget to change`<L1URL>` part with the `https` part that you copied from Alchemy.
Run command below to get latest image
```shell
curl -s https://api.github.com/repos/OffchainLabs/nitro/releases/latest | grep -oP 'Docker image on Docker Hub at `\K(.*)(?=`)'
```

and then run
```shell
docker run -d -v ~/data/arbitrum:/home/user/.arbitrum -p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 offchainlabs/nitro-node:v2.0.9-51f9452 --l1.url <L1URL> --l2.chain-id=42161 --http.api=net,web3,eth,debug --http.corsdomain=* --http.addr=0.0.0.0 --http.vhosts=* --init.url="https://snapshot.arbitrum.io/mainnet/nitro.tar"
```
