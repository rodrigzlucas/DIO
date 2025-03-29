#!/bin/bash

diretorios=(
  '/publico'
  '/adm'
  '/ven'
  '/sec'
)
grupos=(
  'GRP_ADM'
  'GRP_VEN'
  'GRP_SEC'
)
usuarios=(
  'carlos'
  'maria'
  'joao'
  'debora'
  'sebastiana'
  'roberto'
  'josefina'
  'amanda'
  'rogerio'
)

criar_grupo() {
  local group=$1
  if ! getent group "$group" &>/dev/null; then
    echo "Criando grupo: $group"
    groupadd "$group"
    echo "Grupo '$group' criado com sucesso!"
  else
    echo "Grupo '$group' já existe."
  fi
}

criar_usuario() {
  local user=$1
  local group=$2
  if ! id "$user" &>/dev/null; then
    echo "Criando usuário: $user"
    useradd "$user" -m -s /bin/bash -g "$group" -p "$(openssl passwd -6 Senha123)"
    echo "Usuário '$user' criado e adicionado ao grupo '$group'."
  else
    echo "Usuário '$user' já existe."
  fi
}

criar_diretorio() {
  local dir=$1
  local perm=$2
  if [ ! -d "$dir" ]; then
    echo "Criando diretório: $dir"
    mkdir "$dir"
    chmod "$perm" "$dir"
    echo "Diretório $dir criado com permissões $perm."
  else
    echo "Diretório $dir já existe."
  fi
}

for group in "${grupos[@]}"; do
  criar_grupo "$group"
done

for i in "${!usuarios[@]}"; do
  case $i in
  0 | 1 | 2) criar_usuario "${usuarios[i]}" "GRP_ADM" ;;
  3 | 4 | 5) criar_usuario "${usuarios[i]}" "GRP_VEN" ;;
  *) criar_usuario "${usuarios[i]}" "GRP_SEC" ;;
  esac
done

criar_diretorio "/publico" 777
criar_diretorio "/adm" 770
criar_diretorio "/ven" 770
criar_diretorio "/sec" 770

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

echo "Script concluído com sucesso!"
