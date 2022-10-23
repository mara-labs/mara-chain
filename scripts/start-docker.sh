#!/bin/bash

KEY="mykey"
CHAINID="mara_9000-1"
MONIKER="mymoniker"
DATA_DIR=$(mktemp -d -t mara-datadir.XXXXX)

echo "create and add new keys"
./marad keys add $KEY --home $DATA_DIR --no-backup --chain-id $CHAINID --algo "eth_secp256k1" --keyring-backend test
echo "init Mara with moniker=$MONIKER and chain-id=$CHAINID"
./marad init $MONIKER --chain-id $CHAINID --home $DATA_DIR
echo "prepare genesis: Allocate genesis accounts"
./marad add-genesis-account \
"$(./marad keys show $KEY -a --home $DATA_DIR --keyring-backend test)" 1000000000000000000amara,1000000000000000000stake \
--home $DATA_DIR --keyring-backend test
echo "prepare genesis: Sign genesis transaction"
./marad gentx $KEY 1000000000000000000stake --keyring-backend test --home $DATA_DIR --keyring-backend test --chain-id $CHAINID
echo "prepare genesis: Collect genesis tx"
./marad collect-gentxs --home $DATA_DIR
echo "prepare genesis: Run validate-genesis to ensure everything worked and that the genesis file is setup correctly"
./marad validate-genesis --home $DATA_DIR

echo "starting mara node $i in background ..."
./marad start --pruning=nothing --rpc.unsafe \
--keyring-backend test --home $DATA_DIR
--log-level debug
# nullify log output
# >$DATA_DIR/node.log 2>&1 & disown

echo "started mara node"
