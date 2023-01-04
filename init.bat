
rem ethermint compile on windows
rem install golang, gcc, sed for windows
rem 1. install msys2 : https://www.msys2.org/
rem 2. pacman -S mingw-w64-x86_64-toolchain
rem    pacman -S git
rem    pacman -S sed
rem    pacman -S mingw-w64-x86_64-jq
rem 3. add path C:\msys64\mingw64\bin
rem             C:\msys64\usr\bin

set KEY="mykey"
set CHAINID="mara_9000-1"
set MONIKER="localtestnet"
set KEYRING="test"
set KEYALGO="eth_secp256k1"
set LOGLEVEL="debug"
rem to trace evm
set TRACE="--trace"
rem TRACE=""
set HOME=%USERPROFILE%\.marad
echo %HOME%
set ETHCONFIG=%HOME%\config\config.toml
set GENESIS=%HOME%\config\genesis.json
set TMPGENESIS=%HOME%\config\tmp_genesis.json

@echo build binary
go build .\cmd\marad

@REM @echo clear home folder
@REM del /s /q %HOME%

@REM marad config keyring-backend %KEYRING%
@REM marad config chain-id %CHAINID%

@REM marad keys add %KEY% --keyring-backend %KEYRING% --algo %KEYALGO%

@REM rem Set moniker and chain-id for Mara (Moniker can be anything, chain-id must be an integer)
@REM marad init %MONIKER% --chain-id %CHAINID%

@REM rem Change parameter token denominations to amara
@REM cat %GENESIS% | jq ".app_state[\"staking\"][\"params\"][\"bond_denom\"]=\"amara\""   >   %TMPGENESIS% && move %TMPGENESIS% %GENESIS%
@REM cat %GENESIS% | jq ".app_state[\"crisis\"][\"constant_fee\"][\"denom\"]=\"amara\"" > %TMPGENESIS% && move %TMPGENESIS% %GENESIS%
@REM cat %GENESIS% | jq ".app_state[\"gov\"][\"deposit_params\"][\"min_deposit\"][0][\"denom\"]=\"amara\"" > %TMPGENESIS% && move %TMPGENESIS% %GENESIS%
@REM cat %GENESIS% | jq ".app_state[\"mint\"][\"params\"][\"mint_denom\"]=\"amara\"" > %TMPGENESIS% && move %TMPGENESIS% %GENESIS%

@REM rem increase block time (?)
@REM cat %GENESIS% | jq ".consensus_params[\"block\"][\"time_iota_ms\"]=\"30000\"" > %TMPGENESIS% && move %TMPGENESIS% %GENESIS%

@REM rem gas limit in genesis
@REM cat %GENESIS% | jq ".consensus_params[\"block\"][\"max_gas\"]=\"10000000\"" > %TMPGENESIS% && move %TMPGENESIS% %GENESIS%

@REM rem setup
@REM sed -i "s/create_empty_blocks = true/create_empty_blocks = false/g" %ETHCONFIG%

@REM rem Allocate genesis accounts (cosmos formatted addresses)
@REM marad add-genesis-account %KEY% 100000000000000000000000000amara --keyring-backend %KEYRING%

@REM rem Sign genesis transaction
@REM marad gentx %KEY% 1000000000000000000000amara --keyring-backend %KEYRING% --chain-id %CHAINID%

@REM rem Collect genesis tx
@REM marad collect-gentxs

@REM rem Run this to ensure everything worked and that the genesis file is setup correctly
@REM marad validate-genesis

@REM rem Start the node (remove the --pruning=nothing flag if historical queries are not needed)
@REM marad start --pruning=nothing %TRACE% --log_level %LOGLEVEL% --minimum-gas-prices=0.0001amara
