#!/bin/sh

echo "initing RCLONE program"
echo "env content of from_path: $from_path"
echo "env content of to_path: $to_path"
echo "time zone: $TZ"
echo "OPTS: $OPTS"

if [ -z "$intvl" ]
then
  intvl=15
  echo "setting scheduling interval : $intvl"
else
  echo "scheduling interval: $intvl"
fi

intvl=`expr $intvl \* 60`

while [ 1 ]; do
  /bin/rclone_start.sh &
  sleep $intvl
done

exit
