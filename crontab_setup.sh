#!/bin/bash

# sudo ./crontab_setup.sh BTC-USD 192.168.95.128 mysql_user mysql_password
# sudo ./crontab_setup.sh BTC-USD 192.168.95.128 mysql_user mysql_password ETH-USD 
# sudo ./crontab_setup.sh BTC-USD 192.168.95.128 mysql_user mysql_password ETH-USD LTC-USD
# sudo ./crontab_setup.sh 
instrument=$1
mysql_host=$2
mysql_user=$3
mysql_password=$4
instrument2=$5
instrument3=$6

job_command="0 0/1 * * $(whoami) /home/ngsk/Desktop/workspace/Cryptocurrency/poll_data.sh $instrument $mysql_host $mysql_user $mysql_password >> /tmp/poll_data.log 2>&1"
job_command2="0 0/1 * * $(whoami) /home/ngsk/Desktop/workspace/Cryptocurrency/poll_data.sh $instrument2 $mysql_host $mysql_user $mysql_password >> /tmp/poll_data2.log 2>&1"
job_command3="0 0/1 * * $(whoami) /home/ngsk/Desktop/workspace/Cryptocurrency/poll_data.sh $instrument3 $mysql_host $mysql_user $mysql_password >> /tmp/poll_data3.log 2>&1"
target_file=/etc/cron.d/poll_data_cron
target_file2=/etc/cron.d/poll_data2_cron
target_file3=/etc/cron.d/poll_data3_cron

echo "$job_command" > $target_file
echo "$job_command2" > $target_file2
echo "$job_command3" > $target_file3


