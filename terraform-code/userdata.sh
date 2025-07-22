#!/bin/bash
set -e

apt-get update -y
apt-get install -y python3 python3-pip git mysql-client

# Clonar (o actualizar) el repo
cd /home/ubuntu
REPO_URL="${repo_url}"
REPO_NAME=$(basename "$REPO_URL" .git)

if [ ! -d "$REPO_NAME" ]; then
  git clone "$REPO_URL"
else
  cd "$REPO_NAME" && git pull && cd ..
fi

cd "$REPO_NAME"

# Instalar dependencias
pip3 install -r app/requirements.txt

# Esperar a que la BD esté disponible (timeout 5 min)
for i in {1..30}; do
  if mysql -h ${db_host} -u ${db_user} -p${db_password} -e "SELECT 1" >/dev/null 2>&1; then
    echo "MySQL ready"
    break
  fi
  echo "Waiting for MySQL…"
  sleep 10
done

# Seed de la base
mysql -h ${db_host} -u ${db_user} -p${db_password} < init.sql

# Variables de entorno
export DB_HOST=${db_host}
export DB_USER=${db_user}
export DB_PASSWORD=${db_password}
export DB_NAME=store

# Ejecutar Flask en puerto 80
nohup python3 app/app.py --host=0.0.0.0 --port=80 &
