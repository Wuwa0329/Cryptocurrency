#!/bin/bash

# ./poll_data.sh BTC-USD 192.168.95.128 mysql_password
instrument=$1
mysql_host=$2
mysql_password=$3


curl -s "https://data-api.cryptocompare.com/index/cc/v1/historical/minutes?market=cadli&instrument=$instrument&limit=60&aggregate=1&fill=true&apply_mapping=true&response_format=JSON" | \
    jq -r '.Data[] | 
    "INSERT INTO Price (Date, Asset, Volume, Price) VALUES (FROM_UNIXTIME(\(.TIMESTAMP)), \"\(.INSTRUMENT)\", \(.VOLUME), \(.OPEN));"' | \
    mysql -h $mysql_host -u ngsk -p Cryptocurrency --password=$mysql_password
