#!/bin/bash

if [ -z "$4" ];
then
    echo "Mandatory argument missing!"
    echo "Usage: ./poll_data.sh [Instrument] [MYSQL_HOST] [MYSQL_USER] [MYSQL_PASSWORD]"
    echo "Example: ./poll_data.sh BTC-USD 192.168.1.1 mysqluser mysqlpass"
    exit 1
fi

instrument=$1
mysql_host=$2
mysql_user=$3
mysql_password=$4

echo "Polling data for $instrument at $(date +"%Y-%m-%d %H:%M:%S")"

# Poll data api from https://www.coindesk.com/price/bitcoin
curl -s "https://data-api.cryptocompare.com/index/cc/v1/historical/minutes?market=cadli&instrument=$instrument&limit=60&aggregate=1&fill=true&apply_mapping=true&response_format=JSON" | \
    jq -r '.Data[] | 
    "INSERT INTO Price (Date, Asset, Volume, Price, Min_Price, Max_Price) VALUES (FROM_UNIXTIME(\(.TIMESTAMP)), \"\(.INSTRUMENT)\",  \(.VOLUME), \(.OPEN), \(.LOW), \(.HIGH));"' |\
    mysql -h $mysql_host -u $mysql_user -p Cryptocurrency --password=$mysql_password
