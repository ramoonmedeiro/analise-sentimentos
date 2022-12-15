#!/bin/bash

echo "# INSTALL MINIO SERVER"
docker container run --name minio -d -p "9000:9000" -p "9001:9001" -v "$PWD/datalake:/data" minio/minio server /data --console-address ":9001"

echo "# INSTALL APACHE AIRFLOW"
docker container run -d -p 8080:8080 -v "$PWD/airflow/dags:/opt/airflow/dags" --entrypoint=/bin/bash --name airflow apache/airflow:2.2.1-python3.8 -c \
'(airflow db init && airflow users create --username admin --password senha --firstname ramon --lastname medeiro --role Admin --email email) \
; airflow webserver & airflow scheduler'