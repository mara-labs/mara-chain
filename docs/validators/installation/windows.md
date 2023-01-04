<!--
order: 2
-->

# Install on Windows

The following steps are intended to guide you through the process of installling and configuring your validator {synopsis}

:::warning
These instructions are intended for __Windows__ systems. Please follow the [Unix installation guide](unix) if it better suits your needs.
:::

## Step 0: Install dependencies

1. Install [Go](https://go.dev/dl)

2. Install [MSYS2](https://www.msys2.org/).

Once MSYS2 is installed, open a `MSYS2 MINGW64` console and run the following commands:

```bash
pacman -S mingw-w64-x86_64-toolchain # hit enter to install all ✅
pacman -S git
pacman -S sed
pacman -S mingw-w64-x86_64-jq
```

Add the relevant MSYS2 directories to your system's `Path` variable: 

1. `C:\msys64\mingw64\bin`
2. `C:\msys64\usr\bin`

Open a standard terminal of your choice and verify the packages are available to you:

```bash
gcc --version # e.g. gcc (Rev6, Built by MSYS2 project) 12.2.0
git version # e.g. git version 2.39.0
go version # e.g. go version go1.19.4 windows/amd64
```

## Step 1: Build `marad`

```bash
git clone https://github.com/mara-labs/mara-chain
cd mara-chain
git fetch
init.bat
# TODO: git checkout v1.2.3.4.5
# make install
```



