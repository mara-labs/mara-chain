#!/bin/bash

KEY="mykey"
CHAINID="mara_9000-1"
MONIKER="localtestnet"

# stop and remove existing daemon and client data and process(es)
rm -rf ~/.mara*
pkill -f "mara*"

make build-mara

# if $KEY exists it should be override
"$PWD"/build/marad keys add $KEY --keyring-backend test --algo "eth_secp256k1"

# Set moniker and chain-id for Mara (Moniker can be anything, chain-id must be an integer)
"$PWD"/build/marad init $MONIKER --chain-id $CHAINID

# Change parameter token denominations to amara
cat $HOME/.mara/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.mara/config/tmp_genesis.json && mv $HOME/.mara/config/tmp_genesis.json $HOME/.mara/config/genesis.json
cat $HOME/.mara/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="amara"' > $HOME/.mara/config/tmp_genesis.json && mv $HOME/.mara/config/tmp_genesis.json $HOME/.mara/config/genesis.json
cat $HOME/.mara/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="amara"' > $HOME/.mara/config/tmp_genesis.json && mv $HOME/.mara/config/tmp_genesis.json $HOME/.mara/config/genesis.json
cat $HOME/.mara/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="amara"' > $HOME/.mara/config/tmp_genesis.json && mv $HOME/.mara/config/tmp_genesis.json $HOME/.mara/config/genesis.json

# Allocate genesis accounts (cosmos formatted addresses)
"$PWD"/build/marad add-genesis-account "$("$PWD"/build/marad keys show "$KEY" -a --keyring-backend test)" 100000000000000000000amara,10000000000000000000stake --keyring-backend test

# Sign genesis transaction
"$PWD"/build/marad gentx $KEY 10000000000000000000stake --amount=100000000000000000000amara --keyring-backend test --chain-id $CHAINID

# Collect genesis tx
"$PWD"/build/marad collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
"$PWD"/build/marad validate-genesis

# Start the node (remove the --pruning=nothing flag if historical queries are not needed) in background and log to file
"$PWD"/build/marad start --pruning=nothing --rpc.unsafe --json-rpc.address="0.0.0.0:8545" --keyring-backend test > marad.log 2>&1 &

# Give marad node enough time to launch
sleep 5

solcjs --abi "$PWD"/tests/solidity/suites/basic/contracts/Counter.sol --bin -o "$PWD"/tests/solidity/suites/basic/counter
mv "$PWD"/tests/solidity/suites/basic/counter/*.abi "$PWD"/tests/solidity/suites/basic/counter/counter_sol.abi 2> /dev/null
mv "$PWD"/tests/solidity/suites/basic/counter/*.bin "$PWD"/tests/solidity/suites/basic/counter/counter_sol.bin 2> /dev/null

# Query for the account
ACCT=$(curl --fail --silent -X POST --data '{"jsonrpc":"2.0","method":"eth_accounts","params":[],"id":1}' -H "Content-Type: application/json" http://localhost:8545 | grep -o '\0x[^"]*')
echo "$ACCT"

# Start testcases (not supported)
# curl -X POST --data '{"jsonrpc":"2.0","method":"personal_unlockAccount","params":["'$ACCT'", ""],"id":1}' -H "Content-Type: application/json" http://localhost:8545

#PRIVKEY="$("$PWD"/build/marad keys export $KEY)"

## need to get the private key from the account in order to check this functionality.
cd tests/solidity/suites/basic/ && go get && go run main.go $ACCT

# After tests
# kill test marad
echo "going to shutdown marad in 3 seconds..."
sleep 3
pkill -f "mara*"