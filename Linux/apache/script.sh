#!/bin/bash

atualizar_instalar_dependencias() {
    apt update && apt upgrade -y &&
        apt install -y apache2 unzip &&
        apt autoremove -y
}

verificar_instalacoes() {
    if ! command -v wget &>/dev/null; then
        echo "wget não está instalado. Instalando..."
        apt install -y wget
    else
        echo "wget já está instalado."
    fi

    if ! command -v nano &>/dev/null; then
        echo "nano não está instalado. Instalando..."
        apt install -y nano
    else
        echo "nano já está instalado."
    fi
}

baixar_mover_arquivos() {
    if wget -O /tmp/main.zip https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip; then
        unzip /tmp/main.zip -d /tmp &&
            cp -R /tmp/linux-site-dio-main/* /var/www/html &&
            cp -R /tmp/linux-site-dio-main/.* /var/www/html 2>/dev/null || true &&
            rm -rf /tmp/main.zip /tmp/linux-site-dio-main
        echo "Arquivos baixados e movidos com sucesso!"
    else
        echo "Falha ao baixar o arquivo. Verifique a conexão ou o link!"
        exit 1
    fi
}

configurar_server_name() {
    container_ip=$(hostname -I | awk '{print $1}')
    echo "Configurando ServerName para o IP do container: $container_ip"

    echo "ServerName $container_ip" | tee -a /etc/apache2/apache2.conf >/dev/null

    if command -v systemctl &>/dev/null; then
        systemctl restart apache2
    else
        service apache2 start
    fi

    echo "ServerName configurado e Apache reiniciado!"
}

atualizar_instalar_dependencias
verificar_instalacoes
baixar_mover_arquivos
configurar_server_name
