#!/bin/bash
# Script de backup do Nexus
#Function LimpaArquivos
function LimpaArquivos () {

	local DIR=$1

	cd $DIR

	numero_arquivos=$(ls -1 | wc -l)
	if [ "$numero_arquivos" -gt 1 ]; then
	   # Listar os arquivos por data e hora e manter os 3 últimos
	   arquivos_a_manter=$(ls -1t | head -n 1)
	   # Listar os arquivos restantes (para exclusão)
	   arquivos_a_remover=$(ls -1t | tail -n +2)
	   # Remover os arquivos mais antigos
	   for arquivo in $arquivos_a_remover
	   do
		   rm "$arquivo"
		   echo "Arquivo $arquivo removido."
	   done
	else
	   echo “O número de arquivos é igual ou inferior a 1. Nenhuma ação necessária.”
	fi
}


NEXUS_DATA=/opt/nexusdata/
NFS_DIR=/mnt/win_share/
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

echo “INICIANDO BACKUP”

cd $NEXUS_DATA

pwd

#compactando pastas de dados
echo “COMPACTANDO PASTAS”
tar -czf nexus_backup.tar.gz upgrade/ nexus3/blobs/ nexus3/etc/ssl/ nexus3/keystores/

#movendo para pastas de backup
echo “MOVENDO PARA PASTA DE BACKUP”
mv nexus_backup.tar.gz  $NFS_DIR/nexus_backup_$TIMESTAMP.tar.gz

# Verificar se existe mais de 1 arquivo no diretório NFS
LimpaArquivos $NFS_DIR

echo "PROCESSO DE BACKUP CONCLUIDO"