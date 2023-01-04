<!--
order: 1
-->

# Install on Unix

The following steps are intended to guide you through the process of installling and configuring your validator {synopsis}

:::warning
These instructions are intended for __Unix__ systems. Please follow the [Windows installation guide](windows) if it better suits your needs.
:::

## Step 0: Install dependencies

1. Install [Go](https://go.dev/dl)

With `apt`:

```bash
curl -O https://go.dev/dl/go1.19.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz

go version # should output `go version go1.19.4 `
```

2. Install [jq](https://stedolan.github.io/jq/download/)

With `apt`:

```bash
sudo apt install jq
```

3. Other pre-requisites

:::tip
Install the following packages if they are not already present on your system
:::

With `apt`:

```bash
sudo apt install make build-essential gcc git -y
```

## Step 1: Build `marad`

```bash
git clone https://github.com/mara-labs/mara-chain
cd mara-chain
git fetch
# TODO: git checkout v1.2.3.4.5
make install
```

:::tip
If you encounter errors when running `make install`, ensure the necessary [dependencies](#step-0-install-dependencies) are installed and included in your path
:::

After installation is complete, check that the `marad` binary has been successfully installed:

```
marad version
```

## Step 2: Configure 

TODO
