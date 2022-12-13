#!/bin/bash

echo -e "\e[1m\e[32m1. Updating the server, installing docker.. \e[0m"
echo "======================================================"
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io -y
mkdir -p ~/data/arbitrum
chmod -fR 777 ~/data/arbitrum

if [ ! $L1URL ]; then
	read -p "Enter your L1 URL: " L1URL
	echo 'export L1URL='$L1URL >> $HOME/.bash_profile
fi


echo -e "\e[1m\e[32m1. Installing Arbitrum Node.. \e[0m"
echo "======================================================"

# docker image pull offchainlabs/arbitrum-node:latest from ref: https://hub.docker.com/r/offchainlabs/nitro-node/tags
curl -s https://api.github.com/repos/OffchainLabs/nitro/releases/latest | grep -oP 'Docker image on Docker Hub at `\K(.*)(?=`)'
image_name=$(curl -s https://api.github.com/repos/OffchainLabs/nitro/releases/latest | grep -oP 'Docker image on Docker Hub at `\K(.*)(?=`)')
echo "Install latest image: $image_name"
docker run -d -v ~/data/arbitrum:/home/user/.arbitrum -p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 $image_name --l1.url $L1URL --l2.chain-id=42161 --http.api=net,web3,eth,debug --http.corsdomain=* --http.addr=0.0.0.0 --http.vhosts=* --init.url="https://snapshot.arbitrum.io/mainnet/nitro.tar"
