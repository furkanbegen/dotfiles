#!/bin/sh

LINK='https://api.binance.com/api/v3/avgPrice?symbol='
BTC=$(curl $LINK'BTCUSDT' 2>/dev/null | jq -r '.price')
CHZ=$(curl $LINK'CHZUSDT' 2>/dev/null | jq -r '.price')

printf ': %.4f CHZ: %.4f' $BTC $CHZ
