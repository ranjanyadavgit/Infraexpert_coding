#! /bin/bash

THRESHOLD=90

DISK_USAGE=$(df -h / | awk 'NR==2{print $5}' | sed s/%//)

if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
  echo "Warning: Disk usage on server $HOSTNAME has exceed $THRESHOLD%." | mail -s "Disk space alert" mail@mail.com
  exit 1;
else
  echo "Disk usage is below $THRESHOLD%."
  exit 0;
fi
