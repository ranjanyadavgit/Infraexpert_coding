Website Uptime Monitoring Script

This is a simple Bash script to monitor website availability.
It checks if a given URL is responding with HTTP status 200 (OK) or 301 (Moved Permanently).
If the site is down, it sends an email alert to the specified email address.

Features

Checks website availability using curl.

Alerts only when the website is not reachable (status code not 200/301).

Sends an email notification with mail command.

Lightweight and easy to integrate into a cron job for continuous monitoring.

Requirements

Linux/Unix system

curl installed

mail (or mailx) configured with an SMTP server

Usage
./website_monitor.sh <url> <email_address>

Example
./website_monitor.sh https://example.com admin@example.com

If the website is up →

Website is up.

If the website is down →

Website is down

and an email will be sent:

Subject: Website Down
Body: https://example.com website is down.
-------------------------
📝 Explanation
1. #! /bin/bash
   ----
This is the shebang line.

It tells the system to use the Bash shell (/bin/bash) to interpret the script.

2. url=$1
   ----

$1 represents the first argument passed to the script.

This assigns the first argument (the website URL) to the variable url.

./website_monitor.sh https://example.com admin@example.com

3. email_address=$2
   ----

$2 represents the second argument passed to the script.

This assigns the second argument (the email address for alerts) to the variable email_address.

Continuing the above example:
email_address=admin@example.com.

4.status_code=$(curl -Is "$url" | head -1 | awk '{print $2}')
  ----

Runs a command substitution (everything inside $() runs and its output is stored in status_code).

curl -Is "$url"

-I → fetch only the HTTP headers (not the body).

-s → silent mode (no progress meter).

Example output:

HTTP/1.1 200 OK
Date: Thu, 29 Aug 2025 12:00:00 GMT

head -1 → takes only the first line (HTTP/1.1 200 OK).

awk '{print $2}' → prints the second field (200).

So, status_code will contain 200, 301, 404, etc.

5.if [[ "$status_code" -eq 200 || "$status_code" -eq 301 ]]; then
----

This if statement checks if the status code is either 200 (OK) or 301 (Moved Permanently).

-eq means "equal to" (numeric comparison).

|| means "OR".

So, condition is true if website is up or redirected.

6.echo "Website is up."
----

If condition is true → print this message to the console.

7. else
   ----

Runs if the status code is not 200 or 301.


8. echo "Website is down"
   ----

Prints message to console.

9. echo "$url website is down." | mail -s "Website Down" $email_address
   ----  

Sends an email alert using the mail command.

echo "$url website is down." → creates the body of the email.

| → pipes it into the next command.

mail -s "Website Down" $email_address

-s sets the subject line.

$email_address is the recipient

10. fi
    ----

Ends the if statement.
