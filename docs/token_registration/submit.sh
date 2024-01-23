#!/bin/bash

DESCRIPTION=$(cat proposal.md)
TOKEN_ADDRESS="0x1cFc8f1FE8D5668BAFF2724547EcDbd6f013a280"

evmosd tx gov submit-legacy-proposal register-erc20 $TOKEN_ADDRESS \
    --from "proposal" \
    --gas auto \
    --fees 90000000000000000aevmos \
    --gas 3500000 \
    --chain-id evmos_9001-2 \
    --title "Register BERLIN Token as an IBC Coin" \
    --deposit 100000000000000000aevmos \
    --description "${DESCRIPTION}" \
    --node https://tm.evmos.lava.build:443
