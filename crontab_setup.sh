#!/bin/bash

# sudo ./crontab_setup.sh BTC-USD 192.168.95.128 mysql_user mysql_password
instrument=$1
mysql_host=$2
mysql_user=$3
mysql_password=$4

job_command="0 0/1 * * $(whoami) /home/ngsk/Desktop/workspace/Cryptocurrency/poll_data.sh $instrument $mysql_host $mysql_user $mysql_password >> /tmp/poll_data.log 2>&1"
target_file=/etc/cron.d/poll_data_cron
echo "$job_command" > $target_file

