#!/bin/bash

# Nombre de la red externa
NETWORK_NAME="tiktoc_new_net"

# Verificar si la red externa existe
echo "Verificando si la red '$NETWORK_NAME' existe..."
if docker network ls | grep -q $NETWORK_NAME; then
    echo "La red '$NETWORK_NAME' ya existe."
else
    echo "La red '$NETWORK_NAME' no existe. Creándola..."
    docker network create $NETWORK_NAME
    if [ $? -eq 0 ]; then
        echo "Red '$NETWORK_NAME' creada exitosamente."
    else
        echo "Error al crear la red '$NETWORK_NAME'."
        exit 1
    fi
fi

# Levantar servicios con docker-compose
echo "Iniciando servicios con docker-compose..."
docker-compose up --build -d
if [ $? -eq 0 ]; then
    echo "Servicios levantados exitosamente."
else
    echo "Error al levantar los servicios."
    exit 1
fi

# Verificar si los contenedores están corriendo
echo "Verificando contenedores en ejecución..."
docker ps --format "table {{.Names}}\t{{.Status}}"

echo "Proceso completado. Puedes verificar los servicios manualmente si es necesario."
