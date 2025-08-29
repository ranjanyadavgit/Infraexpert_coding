#! /bin/bash

url=$1
email_address=$2

status_code=$(curl -Is "$url" | head -1 | awk '{print $2}')

if [[ "$status_code" -eq 200 || "$status_code" -eq 301 ]]; then
  echo "Website is up."
else
  echo "Website is down"
  echo "$url website is down." | mail -s "Website Down" $email_address 
fi
