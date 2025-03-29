#!/usr/bin/env bash

set -e

apt-get update -y
apt-get upgrade -y

PROGRAMS=(
    "ca-certificates"
    "curl"
    "gnupg"
    "lsb-release"
)

instalar_programas_necessarios() {
    for program in "${PROGRAMS[@]}"; do
        if ! dpkg -l | grep -q "^ii  $program "; then
            echo "$program não está instalado. Instalando..."
            apt-get install -y "$program"
        else
            echo "$program está instalado."
        fi
    done
}

DOCKER_INSTALL=(
    "docker-ce"
    "docker-ce-cli"
    "containerd.io"
    "docker-buildx-plugin"
    "docker-compose-plugin"
)

mkdir -p /etc/apt/keyrings

instalar_docker() {
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg || exit 1

    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
        https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null

    for DOCKER in "${DOCKER_INSTALL[@]}"; do
        if ! dpkg -l | grep -q "^ii  $DOCKER "; then
            echo "$DOCKER não está instalado. Instalando..."
            apt-get install -y "$DOCKER"
        else
            echo "$DOCKER está instalado."
        fi
    done

    if pidof systemd >/dev/null; then
        systemctl restart docker
    else
        service docker restart
    fi

}

criar_container_mysql() {
    echo -n "Digite o nome do container: "
    read CONTAINER_NAME

    echo -n "Digite uma senha para o banco de dados: "
    read -s MYSQL_PASSWORD
    echo

    export CONTAINER_NAME MYSQL_PASSWORD

    docker volume create mysql_data
    docker run --name "$CONTAINER_NAME" -e MYSQL_ROOT_PASSWORD="$MYSQL_PASSWORD" -dt -p 3306:3306 -v mysql_data:/var/lib/mysql mysql:8.0
    docker ps
}

configurar_banco() {
    echo -n "Digite o nome do banco de dados: "
    read DATABASE_NAME

    docker exec -i "$CONTAINER_NAME" mysql -u root -p"$MYSQL_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;"
}

criar_arquivo_no_volume() {
    echo -n "Digite o caminho da pasta: "
    read PAST

    VOLUME_PATH="/var/lib/docker/volumes/mysql_data/_data"

    if [ -z "$PAST" ]; then
        echo "Você precisa fornecer o caminho da pasta a ser movida."
        return 1
    fi

    if [ ! -d "$PAST" ]; then
        echo "A pasta fornecida não existe: $PAST"
        return 1
    fi

    mkdir -p "$VOLUME_PATH"
    chmod -R u+w "$VOLUME_PATH"

    echo "Movendo a pasta do projeto $PAST para $VOLUME_PATH..."
    mv "$PAST" "$VOLUME_PATH/"

    echo "Pasta movida com sucesso!"
}

criar_servidor() {
    echo -n "Digite o nome da imagem do container: "
    read IMAGE

    echo -n "Digite um nome para o servidor: "
    read SERVER_NAME

    if docker ps -a --format '{{.Names}}' | grep -q "^$SERVER_NAME$"; then
        echo "O servidor $SERVER_NAME já existe. Ignorando a criação."
        return 0
    fi

    docker run --name "$SERVER_NAME" -dt -p 80:80 --mount type=volume,src=mysql_data,dst=/app "$IMAGE"
    docker ps
}

iniciar_cluster() {
    echo -n "Digite o nome do servidor em execução para configurar o cluster: "
    read SERVER_NAME

    docker rm -f "$SERVER_NAME"
    docker swarm init

    echo "Anote o comando 'docker swarm join' exibido acima e execute-o nas outras máquinas."

    while true; do
        read -p "Você executou o 'docker swarm join' nas outras máquinas? (s/n): " confirmacao
        case "$confirmacao" in
        [Ss]*) break ;;
        [Nn]*)
            echo "Aguardando..."
            sleep 3
            ;;
        *) echo "Responda 's' ou 'n'." ;;
        esac
    done

    echo "Cluster iniciado com sucesso!"
    docker node ls
}

criar_servico_cluster() {
    echo -n "Digite o nome da imagem do container: "
    read IMAGE

    echo -n "Digite um nome para o serviço: "
    read SERVER_NAME

    echo -n "Digite o total de réplicas: "
    read REPLICATES

    docker service create \
        --name "$SERVER_NAME" \
        --replicas "$REPLICATES" \
        -p 80:80 \
        --mount type=volume,src=mysql_data,dst=/app \
        "$IMAGE"

    docker service ps "$SERVER_NAME"
}

replicar_cluster() {
    echo "Instalando NFS Server..."
    apt install nfs-kernel-server -y

    EXPORTS_FILE="/etc/exports"
    NFS_PATH="/var/lib/docker/volumes/mysql_data/_data"
    PERMISSOES="*(rw,sync,no_subtree_check,no_root_squash)"

    if ! grep -q "$NFS_PATH" "$EXPORTS_FILE"; then
        echo "$NFS_PATH $PERMISSOES" | sudo tee -a "$EXPORTS_FILE" >/dev/null
    fi

    if pidof systemd >/dev/null; then
        systemctl restart nfs-kernel-server
    else
        service nfs-kernel-server start
    fi

    exportfs -ar
    showmount -e
}

liberar_acesso_pastas() {
    IP_LOCAL=$(hostname -I | awk '{print $1}')

    echo "Comando para executar nas outras máquinas:"
    echo "sudo mount -o vers=3 $IP_LOCAL:/var/lib/docker/volumes/mysql_data/_data /var/lib/docker/volumes/mysql_data/_data"

    while true; do
        read -p "Você liberou o acesso às pastas nas outras máquinas? (s/n): " confirmacao
        case "$confirmacao" in
        [Ss]*) break ;;
        [Nn]*)
            echo "Aguardando..."
            sleep 3
            ;;
        *) echo "Responda 's' ou 'n'." ;;
        esac
    done
}

criar_proxy() {
    echo -n "Digite o nome para o proxy: "
    read PROXY_NAME

    mkdir -p /proxy

    wget -O /proxy/nginx.conf https://raw.githubusercontent.com/denilsonbonatti/toshiro-shibakita/main/nginx.conf
    wget -O /proxy/Dockerfile https://raw.githubusercontent.com/denilsonbonatti/toshiro-shibakita/main/dockerfile

    docker build -t "$PROXY_NAME" /proxy
    docker run --name "$PROXY_NAME" -dti -p 4500:4500 "$PROXY_NAME"
    docker container ls
}

instalar_programas_necessarios
instalar_docker
criar_container_mysql
configurar_banco
criar_arquivo_no_volume
criar_servidor
iniciar_cluster
criar_servico_cluster
replicar_cluster
liberar_acesso_pastas
criar_proxy
