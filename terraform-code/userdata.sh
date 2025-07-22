#!/bin/bash
set -e

# 0) Instala paquetes necesarios
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  python3 python3-pip unzip awscli mysql-client

# 1) Trabaja en home y descarga la app
cd /home/ubuntu
aws s3 cp s3://${bucket}/${zip_key} app.zip
unzip -o app.zip

# 2) Instala dependencias Python
cd app
pip3 install --no-cache-dir -r requirements.txt

# 3) Espera a que RDS esté lista
for i in {1..30}; do
  if mysql -h ${db_host} -u ${db_user} -p${db_pass} -e "SELECT 1" &>/dev/null; then
    echo "MySQL is up"
    break
  fi
  echo "Waiting for MySQL..."
  sleep 10
done

# 4) Seed de la base de datos
mysql -h ${db_host} -u ${db_user} -p${db_pass} < ../init.sql

# 5) Exporta las credenciales de la BD ANTES de arrancar Flask
export DB_HOST=${db_host}
export DB_USER=${db_user}
export DB_PASSWORD=${db_pass}
export DB_NAME=store

# 6) Arranca Flask en background en el puerto 80
nohup python3 app.py --host=0.0.0.0 --port=80 > flask.log 2>&1 &
