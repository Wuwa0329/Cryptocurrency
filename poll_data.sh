#!/bin/bash

# BTC-USD
instrument=$1

curl "https://data-api.cryptocompare.com/index/cc/v1/historical/minutes?market=cadli&instrument=$instrument"