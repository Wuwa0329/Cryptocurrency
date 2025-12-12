#!/bin/bash

# ./plot_data.sh BTC-USD 192.168.95.128 mysql_user mysql_password
instrument=$1
mysql_host=$2
mysql_user=$3
mysql_password=$4
tmp_csv="$(mktemp /tmp/XXXXXX.csv)"

# mysql OUTFILE does not work if file already exists
rm $tmp_csv

mysql -h $mysql_host -u $mysql_user -p Cryptocurrency --password=$mysql_password \
    -e "SELECT DATE_FORMAT(Date, '%Y-%m-%dT%H:%i:%s'), Price INTO OUTFILE '$tmp_csv' FROM Price WHERE Asset='$instrument' ORDER BY Date ASC;"

gnuplot -e "
    set terminal png;
    set output 'price_plot.png';
    set title '$instrument Price Over Time';
    set xlabel 'Time';
    set xdata time;
    set timefmt '%Y-%m-%dT%H:%M:%S';
    set format x '%H:%M';
    set ylabel 'Price (USD)';
    set grid;
    plot '$tmp_csv' using 1:2 w l t 'Price';"