#!/bin/bash

nibid init $NIBIRU_MONIKER --chain-id $NIBIRU_CHAIN
nibid config chain-id $NIBIRU_CHAIN
#curl -s https://rpc.testnet-2.nibiru.fi/genesis | jq -r .result.genesis > $HOME/.nibid/config/genesis.json
curl -s $NIBIRU_GENESIS_FILE > $HOME/.nibid/config/genesis.json


sed -i 's|seeds =.*|seeds = "'$(curl -s $NIBIRU_SEEDS_FILE)'"|g' $HOME/.nibid/config/config.toml
# sed -i 's/indexer =.*/indexer = "null"/g' $HOME/.nibid/config/app.toml
if grep -q '^indexer =' $HOME/.nibid/config/app.toml; then
  sed -i 's/^indexer =.*/indexer = "null"/g' $HOME/.nibid/config/app.toml
else
  echo 'indexer = "null"' >> $HOME/.nibid/config/app.toml
fi


sed -i 's/minimum-gas-prices =.*/minimum-gas-prices = "0.025unibi"/g' $HOME/.nibid/config/app.toml
sed -i 's|enable =.*|enable = true|g' $HOME/.nibid/config/config.toml
sed -i 's|rpc_servers =.*|rpc_servers = "'$(curl -s $NIBIRU_RPC_SERVERS_FILE)'"|g' $HOME/.nibid/config/config.toml
sed -i 's|trust_height =.*|trust_height = "'$(curl -s $NIBIRU_TRUST_HEIGHT_FILE)'"|g' $HOME/.nibid/config/config.toml
sed -i 's|trust_hash =.*|trust_hash = "'$(curl -s $NIBIRU_TRUST_HASH_FILE)'"|g' $HOME/.nibid/config/config.toml

curl -L https://snapshots.kjnodes.com/nibiru-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.nibid


