#!/bin/sh

LINK='https://freecurrencyapi.net/api/v2/latest?apikey='$CURRENCY_API_KEY
USD=$(curl $LINK 2>/dev/null | jq -r '.data.TRY')
EUR=$(curl $LINK'&base_currency=EUR' 2>/dev/null | jq -r '.data.TRY')

printf  " %.2f  %.2f" $USD $EUR
