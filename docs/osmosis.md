# Listing on Osmosis

Below we outline the steps to have an EVMOS IBC token listed on Osmosis.

## Cosmos Chain Registry Integration

### Setup

Make sure you have an up-to-date version of the NeokingdomDAO fork of the chain registry

```
git clone git@github.com:NeokingdomDAO/chain-registry.git
git remote add upstream https://github.com/cosmos/chain-registry
git fetch upstream
git rebase upstream/master
```

### Update assetlist.json

First, add token logos, both svg and png, inside `evmos/images`.

Locate the assetlist file at `evmos/assetlist.json` and append the following object, filled with the appropriate information:

```
{
      "description": "<description of the token>",
      "denom_units": [
        {
          "denom": "erc20/<the ERC20 0x-address that you submitted in the governance proposal>",
          "exponent": 0
        },
        {
          "denom": "<lower case token name, ex: berlin>",
          "exponent": 18
        }
      ],
      "base": "erc20/<the ERC20 0x-address that you submitted in the governance proposal>",
      "name": "<the name of the project, ex: Teledisko DAO>",
      "display": "<lower case token name, ex: berlin>",
      "symbol": "<upper case token name, ex: BERLIN>",
      "address": "<the ERC20 0x-address that you submitted in the governance proposal>"
      "type_asset": "erc20",
      "logo_URIs": {
        "png": "https://raw.githubusercontent.com/cosmos/chain-registry/master/evmos/images/<png logo file>",
        "svg": "https://raw.githubusercontent.com/cosmos/chain-registry/master/evmos/images/<svg logo file>"
      },
      "images": [
        {
          "png": "https://raw.githubusercontent.com/cosmos/chain-registry/master/evmos/images/<png logo file>",
          "svg": "https://raw.githubusercontent.com/cosmos/chain-registry/master/evmos/images/<svg logo file>"
        }
      ]
    }
```

## Cosmostation Chain List Integration

### Setup

Make sure you have an up-to-date version of the NeokingdomDAO fork of the chain list

```
git clone git@github.com:NeokingdomDAO/chainlist.git
git remote add upstream https://github.com/cosmostation/chainlist.git
git fetch upstream
git rebase upstream/main
```

Install and setup the `evmosd` command line tool to perform IBC transfers. Follow [the official documentation](https://docs.evmos.org/protocol/evmos-cli).

### Test transfer to Osmosis

Transfer as much tokens as you like to an Osmosis wallet, so to be able to show case the necessaary data in the PR.

In the example we are sending 1 unit of the token. If the node in the example commend (after `--node`) does not work, find a new RPC endpoint at https://cosmos.directory/evmos.

```
evmosd tx ibc-transfer transfer transfer "channel-0" <your osmosis wallet>
"1000000000000000000erc20/<the ERC20 0x-address that you submitted in the governance proposal>" --from main --gas-prices 400000000000aevmos
--chain-id evmos_9001-2 --node https://rpc.evmos.tcnetwork.io
```

### Update evmos/erc20.json

First, add the `png` token logo inside `chain/evmos/asset`.

Locate the assets file at `chain/evmos/erc20.json` and append the following object, filled with the appropriate information:

```
  {
    "chainId": 9001,
    "chainName": "evmos",
    "address": "<the ERC20 0x-address that you submitted in the governance proposal>",
    "symbol": "<upper case token name, ex: BERLIN>",
    "description": "<description of the token>",
    "decimals": 18,
    "image": "evmos/asset/<png logo file>",
    "default": false,
    "coinGeckoId": ""
  }
```

### Update osmosis/assets.json

First, calculate the denom for the token going from evmos to osmosis:

```
echo -n "transfer/channel-204/erc20/<the ERC20 0x-address that you submitted in the governance proposal>" | sha256sum | tr '[:lower:]' '[:upper:]'
```

Locate the assets file at `chain/osmosis/assets.json` and append the following object, filled with the appropriate information:

```
  {
    "denom": "ibc/<the denom you calculated in the previous step>",
    "type": "ibc",
    "origin_chain": "evmos",
    "origin_denom": "<lower case token name, ex: berlin>",
    "origin_type": "erc20",
    "symbol": "<uppercase case token name, ex: BERLIN>",
    "decimals": 18,
    "enable": true,
    "path": "evmos>osmosis",
    "channel": "channel-204",
    "port": "transfer",
    "counter_party": {
      "channel": "channel-0",
      "port": "transfer",
      "denom": "erc20/<the ERC20 0x-address that you submitted in the governance proposal>"
    },
    "image": "evmos/asset/<png logo file>",
    "coinGeckoId": ""
  },
```

## EVMOS Chain Token Registry Integration

### Setup

Make sure you have an up-to-date version of the NeokingdomDAO fork of the chain token registry

```
git clone git@github.com:NeokingdomDAO/chain-token-registry.git
git remote add upstream https://github.com/evmos/chain-token-registry.git
git fetch upstream
git rebase upstream/main
```

### Add new token

First, add the `png` token logo inside `assets/tokens`.

Create a JSON named `<token>.json` inside `tokens/` following the template

```
{
  "$schema": "../schema.token.json",
  "coinDenom": "<upper case token name, ex: BERLIN>",
  "minCoinDenom": "<lower case token name, ex: berlin>",
  "type": "IBC",
  "exponent": "18",
  "cosmosDenom": "erc20/<the ERC20 0x-address that you submitted in the governance proposal>",
  "description": "<description of the token>",
  "name": "<the name of the project, ex: Teledisko DAO>",
  "tokenRepresentation": "<upper case token name, ex: BERLIN>",
  "channel": "",
  "isEnabled": true,
  "erc20Address": "<the ERC20 0x-address that you submitted in the governance proposal>",
  "ibc": {
    "sourceDenom": "<lower case token name, ex: berlin>",
    "source": "evmos"
  },
  "hideFromTestnet": false,
  "coingeckoId": "",
  "category": "cosmos",
  "coinSourcePrefix": "evmos",
  "img": {
    "png": "https://raw.githubusercontent.com/evmos/chain-token-registry/main/assets/tokens/<png logo file>"
  }
}
```

## Osmosis Assetlist integration

### Setup

Make sure you have an up-to-date version of the NeokingdomDAO fork of the chain list

```
git clone git@github.com:NeokingdomDAO/assetlist.git
git remote add upstream https://github.com/osmosis-labs/assetlists.git
git fetch upstream
git rebase upstream/main
```

### Update osmosis.zone_assets.json

Locate the assets file at `assetlists/osmosis-1/osmosis.zone_assets.json` and append the following object, filled with the appropriate information:

```
{
    "chain_name": "evmos",
    "base_denom": "erc20/<the ERC20 0x-address that you submitted in the governance proposal>",
    "path": "transfer/channel-204/erc20/<the ERC20 0x-address that you submitted in the governance proposal>",
    "osmosis_verified": false,
    "transfer_methods": [
    {
        "name": "Evmos App",
        "type": "external_interface",
        "deposit_url": "https://app.evmos.org/assets"
    }
    ]
}
```

### Create pools

Install the Osmosis CLI as per [documentation](https://docs.osmosis.zone/osmosis-core/osmosisd/).

Compute the token denom

```
echo -n "transfer/channel-204/erc20/<the ERC20 0x-address that you submitted in the governance proposal>" | sha256sum | tr '[:lower:]' '[:upper:]'
```

#### OSMOS/<TOKEN>

Create a JSON file with the weight definition ofr osmo/<your token base>

```
{
    "weights": "5ibc/<denom you calculated above, ALL CAPS>,5uosmo",
    "initial-deposit": "3000000000000000000ibc/<denom you calculated above, ALL CAPS>,300000uosmo",
    "swap-fee": "0.02",
    "exit-fee": "0.0",
    "future-governor": ""
}
```

Let's call it `osmo.json`.

This will create a pool with 3 of your tokens and 3 osmo.

Execute the pool creation command

```
osmosisd tx gamm create-pool --pool-file osmo.json --fees 0.01osmo --gas 500000 --from main --chain-id osmosis-1
```

ATTENTION: this will cost 100 USDC, that the osmosis wallet must have before issuing the pool creation transaction.

This should output the transaction ID of the pool creation. Grab it and use

```
osmosisd query tx <tx id pool creation>
```

to obtain the Pool ID that you will need for the pool request.

#### axlUSD/<TOKEN>

Create a JSON file with the weight definition ofr axlUSD/<your token base>

```
{
    "weights": "5ibc/<denom you calculated above, ALL CAPS>,5ibc/D189335C6E4A68B513C10AB227BF1C1D38C746766278BA3EEB4FB14124F1D858",
    "initial-deposit": "3000000000000000000ibc/<denom you calculated above, ALL CAPS>,3000000ibc/D189335C6E4A68B513C10AB227BF1C1D38C746766278BA3EEB4FB14124F1D858",
    "swap-fee": "0.02",
    "exit-fee": "0.0",
    "future-governor": ""
}
```

Let's call it `axlusd.json`.

This will create a pool with 3 of your tokens and 3 osmo.

Execute the pool creation command

```
osmosisd tx gamm create-pool --pool-file axlusd.json --fees 0.01osmo --gas 500000 --from main --chain-id osmosis-1
```

ATTENTION: this will cost 100 USDC, that the osmosis wallet must have before issuing the pool creation transaction.

This should output the transaction ID of the pool creation. Grab it and use

```
osmosisd query tx <tx id pool creation>
```

to obtain the Pool ID that you will need for the pool request.

### Open a PR

You can now open the PR, following the template requested by the Osmosis team and taking inspiration from the previously opened PR: https://github.com/osmosis-labs/assetlists/pull/666
