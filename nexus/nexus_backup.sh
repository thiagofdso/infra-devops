#!/bin/bash
# Script de backup do Nexus
NEXUS_DIR=/opt/nexusdata/nexus3/
BACKUP_DIR=/opt/backup
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
echo “INICIANDO BACKUP”
cd “$NEXUS_DIR”
pwd
#compactando pastas de dados
echo “COMPACTANDO PASTAS”
tar -czf nexus_backup.tar.gz db/ blobs/
#movendo para pastas de backup
echo “MOVENDO PARA PASTA DE BACKUP”
mv nexus_backup.tar.gz  “$BACKUP_DIR/nexus_backup_$TIMESTAMP.tar.gz”
#Mudar para o diretorio
cd “$BACKUP_DIR”
#copiando o backup para o ponto de montegem com o fileserver 
cp nexus_backup_$TIMESTAMP.tar.gz /mnt/win_share
 
# Verificar se existem mais de 3 arquivos no diretório
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
echo "PROCESSO DE BACKUP CONCLUIDO"
