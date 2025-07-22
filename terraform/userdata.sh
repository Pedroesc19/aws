#!/bin/bash
apt-get update -y
apt-get install -y python3 python3-pip git mysql-client
cd /home/ubuntu
REPO_URL="${repo_url}"
REPO_NAME=$(basename "$REPO_URL" .git)
if [ ! -d "$REPO_NAME" ]; then
  git clone "$REPO_URL"
fi
cd "$REPO_NAME"
pip3 install -r app/requirements.txt
mysql -h ${db_host} -u ${db_user} -p${db_password} < terraform/init.sql
export DB_HOST=${db_host}
export DB_USER=${db_user}
export DB_PASSWORD=${db_password}
export DB_NAME=store  # opcional
nohup python3 app/app.py &
