# docker-diskmonitor
A docker container image to monitor the current usage percent of the partition
mounted as /.

Warnings will be posted to an incoming webhook in slack.

## Configuration
Configuration is done through environment variables. The following are
available:
- `SLACK_URL` REQUIRED url of the slack webhook
- `SLACK_NOTIFY_USERS` comma separated list of users to notify whe
- `SLEEP` time in between checks, defaults to 5m
- `THRESHOLD` disk usage percent threshold to start warning defaults to 90
- `HOSTFILE` the file to read the hostname from, dfeaults to /etc/hostname but
  it is recommended to set this to /target/etc/hostname and have a volume set up
  `/etc:/target/etc`
- `ENVIRONMENT` if set it will be added in front of the hostname, example
  staging/host123
