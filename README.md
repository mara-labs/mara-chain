<!--
parent:
  order: false
-->

<div align="center">
  <h1> Mara chain </h1>
</div>

Mara chain is a scalable and interoperable Ethereum library, built on Proof-of-Stake with fast finality using the [Cosmos SDK](https://github.com/cosmos/cosmos-sdk/), which runs on top of [Tendermint Core](https://github.com/tendermint/tendermint) consensus engine.

**Note**: Requires [Go 1.18+](https://golang.org/dl/)

## Installation

If you don't have Go installed or configured on your PC, the command `make install` command will return an error `/bin/sh: go: command not found`.

Kindly follow the following steps to install and configure your PC to run the Mara Chain locally.

### Step 1

Download and install Go quickly with the steps described [here](https://go.dev/doc/install).

Next, run `go version` to confirm the installation succeeded.

### Step 2

Run the following command to install dependencies:

```
make install
```

If you haven't installed `jq` already or encounter `jq not found` follow the [guide](https://stedolan.github.io/jq/download/) to install jq.

### Step 3

Navigate to the Mara Chain project directory using the following command.
```
cd mara-chain
```

Verify everything went well by running the following command.

```
which marad
```

You will get the error `marad not found`. This is because you need to set $GOBIN and add it to the path where `marad` would be located. Let's fix that by running the following command:
```
export PATH=$PATH:$(go env GOPATH)/bin
```

The scripts in the rest of this document use `$GOPATH` instead of `$(go env GOPATH)` for brevity. To make the scripts run as written if you have not set `GOPATH`, you can substitute `$HOME/go` in those commands or else run:

```
export GOPATH=$(go env GOPATH)
```
Check [here](https://go.dev/doc/gopath_code#GOPATH) to learn more about GOPATH.

### Step 4

To start up the Mara chain, run the following command:
```
./init.sh
```

Use the following command if you are on windows OS.
```
./init.bat
```

Check out the latest [release](https://github.com/mara-labs/mara-chain/releases).


## Quick Start

To learn how the Mara chain works from a high-level perspective, go to the [Introduction](https://evmos.dev/intro/overview.html) section from the documentation. You can also check the instructions to [Run a Node](https://evmos.dev/quickstart/run_node.html).

For an example of how the Mara Chain can be used on any Cosmos-SDK chain, please refer to [Evmos](https://www.github.com/tharsis/evmos).

## Contributing

Looking for an excellent place to start contributing? Check out some [`good first issues`](https://github.com/mara-labs/mara-chain/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22).