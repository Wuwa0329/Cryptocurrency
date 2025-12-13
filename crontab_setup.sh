#!/bin/bash

# sudo ./crontab_setup.sh BTC-USD 192.168.95.128 mysql_user mysql_password ETH-USD LTC-USD BCH-USD BNB-USD

instrument=$1
mysql_host=$2
mysql_user=$3
mysql_password=$4
instrument2=$5
instrument3=$6
instrument4=$7
instrument5=$8

job_command="0 * * * * $(whoami) /home/ngsk/Desktop/workspace/Cryptocurrency/poll_data.sh $instrument $mysql_host $mysql_user $mysql_password >> /tmp/poll_data.log 2>&1"
job_command2="0 * * * * $(whoami) /home/ngsk/Desktop/workspace/Cryptocurrency/poll_data.sh $instrument2 $mysql_host $mysql_user $mysql_password >> /tmp/poll_data2.log 2>&1"
job_command3="0 * * * * $(whoami) /home/ngsk/Desktop/workspace/Cryptocurrency/poll_data.sh $instrument3 $mysql_host $mysql_user $mysql_password >> /tmp/poll_data3.log 2>&1"
job_command4="0 * * * * $(whoami) /home/ngsk/Desktop/workspace/Cryptocurrency/poll_data.sh $instrument4 $mysql_host $mysql_user $mysql_password >> /tmp/poll_data4.log 2>&1"
job_command5="0 * * * * $(whoami) /home/ngsk/Desktop/workspace/Cryptocurrency/poll_data.sh $instrument5 $mysql_host $mysql_user $mysql_password >> /tmp/poll_data5.log 2>&1"

target_file=/etc/cron.d/poll_data_cron
target_file2=/etc/cron.d/poll_data2_cron
target_file3=/etc/cron.d/poll_data3_cron
target_file4=/etc/cron.d/poll_data4_cron
target_file5=/etc/cron.d/poll_data5_cron    

echo "$job_command" > $target_file
echo "" >> $target_file
echo "$job_command2" > $target_file2
echo "" >> $target_file2
echo "$job_command3" > $target_file3
echo "" >> $target_file3
echo "$job_command4" > $target_file4
echo "" >> $target_file4
echo "$job_command5" > $target_file5
echo "" >> $target_file5
