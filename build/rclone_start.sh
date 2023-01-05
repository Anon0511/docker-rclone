#!/bin/sh

# Check for still running process

if pidof -o %PPID "rclone_start.sh"; then
  echo "rclone is still running"
  exit 1
fi

# Variables

LOGFILE="/rclone/$(echo $to_path | cut -d: -f1)_$JOB.log"

if [ -z "$minage" ]
then
  minage=$intvl
  echo "setting minage : $intvl"
fi

# Check for files older than x

if find $from_path* -type f -mmin +$minage ! -name '*.!qB' | read
  then
  start=$(date +'%s')
  echo "$(date "+%d.%m.%Y %T") RCLONE UPLOAD STARTED" | tee -a $LOGFILE
  /usr/bin/rclone $JOB "$from_path" "$to_path" --filter='- *.!qB' --min-age ${minage}m --log-level=INFO --log-file=$LOGFILE $OPTS
  echo "$(date "+%d.%m.%Y %T") RCLONE UPLOAD FINISHED IN $(($(date +'%s') - $start)) SECONDS" | tee -a $LOGFILE
else
  echo "Nothing to upload"
fi

exit
