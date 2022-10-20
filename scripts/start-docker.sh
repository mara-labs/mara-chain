#!/bin/bash

echo "prepare genesis: Run validate-genesis to ensure everything worked and that the genesis file is setup correctly"
./marad validate-genesis --home /mara

echo "starting mara node $ID in background ..."
./marad start \
--home /mara \
--keyring-backend test

echo "started mara node"
tail -f /dev/null
