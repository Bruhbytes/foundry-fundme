## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

To start the local blockchain server. Open a new terminal and type:

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/DeployFundMe.sol --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### View Storage structure

```shell
$ forge inspect <contract-name> storageLayout
```

This command will provide which state variable occupies which slot in the storage which can help for further research using command `cast storage <contract-addr> <slot-num>`

### Cast

It is used to convert HEX into Decimals and other conversions. Can also be used to interact with contracts.
Using `cast send <contract-address> <function-signature> <args(if any)>` and `cast call` commands

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
