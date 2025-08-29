#Nice script 👍 — you’ve written a disk usage monitoring script in Bash with email alerting. Let me walk through it and suggest a couple of improvements.

#! /bin/bash

THRESHOLD=90

Sets a threshold for disk usage at 90%.
------
DISK_USAGE=$(df -h / | awk 'NR==2{print $5}' | sed s/%//)

# df -h / → gets disk usage of root (/).

awk 'NR==2{print $5}' → extracts the Use% column (e.g., 82%).

sed s/%// → strips the % sign, leaving just the number (e.g., 82).
-------
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
  echo "Warning: Disk usage on server $HOSTNAME has exceed $THRESHOLD%." | mail -s "Disk space alert" mail@mail.com
  exit 1;
else
  echo "Disk usage is below $THRESHOLD%."
  exit 0;
fi

If disk usage exceeds threshold → send an email alert.

Otherwise → print safe message and exit cleanly.

