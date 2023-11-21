#!/bin/bash
# Script de backup do Nexus
#Function LimpaArquivos
function LimpaArquivos () {

	local DIR=$1

	cd $DIR

	numero_arquivos=$(ls -1 | wc -l)
	if [ "$numero_arquivos" -gt 3 ]; then
	   # Listar os arquivos por data e hora e manter os 3 últimos
	   arquivos_a_manter=$(ls -1t | head -n 3)
	   # Listar os arquivos restantes (para exclusão)
	   arquivos_a_remover=$(ls -1t | tail -n +4)
	   # Remover os arquivos mais antigos
	   for arquivo in $arquivos_a_remover
	   do
		   rm "$arquivo"
		   echo "Arquivo $arquivo removido."
	   done
	else
	   echo “O número de arquivos é igual ou inferior a 3. Nenhuma ação necessária.”
	fi
}


NEXUS_DIR=/opt/nexusdata/nexus3/
BACKUP_DIR=/opt/backup/
NFS_DIR=/mnt/win_share/
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

echo “INICIANDO BACKUP”

cd $NEXUS_DIR

pwd

#compactando pastas de dados
echo “COMPACTANDO PASTAS”
tar -czf nexus_backup.tar.gz db/ blobs/ etc/ssl/ keystores/

#movendo para pastas de backup
echo “MOVENDO PARA PASTA DE BACKUP”
mv nexus_backup.tar.gz  $BACKUP_DIR/nexus_backup_$TIMESTAMP.tar.gz

#Mudar para o diretorio
cd $BACKUP_DIR

#copiando o backup para o ponto de montegem com o fileserver 
cp nexus_backup_$TIMESTAMP.tar.gz $NFS_DIR

# Verificar se existem mais de 3 arquivos no diretório backup 
LimpaArquivos $BACKUP_DIR 

# Verificar se existem mais de 3 arquivos no diretório NFS
LimpaArquivos $NFS_DIR

echo "PROCESSO DE BACKUP CONCLUIDO"
