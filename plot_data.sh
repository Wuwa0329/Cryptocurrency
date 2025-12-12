#!/bin/bash

# SELECT DATE_FORMAT(Date, '%Y-%m-%dT%H:%i:%s'), Price INTO OUTFILE 'btc.csv' FIELDS TERMINATED BY ' ' LINES TERMINATED BY '\n' FROM Price;

gnuplot -e "
    set terminal png;
    set output 'price_plot.png';
    set title 'BTC-USD Price Over Time';
    set xlabel 'Time';
    set xdata time;
    set timefmt '%Y-%m-%dT%H:%M:%S';
    set format x '%H:%M';
    set ylabel 'Price (USD)';
    set grid;
    plot 'data/btc.csv' using 1:2 w l t 'Price';"