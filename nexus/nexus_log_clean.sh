#!/bin/bash
# Script de backup do Nexus
NEXUS_LOG_DIR=/opt/nexusdata/nexus3/log/

echo “INICIANDO LIMPEZA nexus.log”
cd “$NEXUS_LOG_DIR”
pwd

numero_arquivos=$(ls nexus-*.log.gz -1 | wc -l)
if [ "$numero_arquivos" -gt 3 ]; then
   # Listar os arquivos por data e hora e manter os 3 últimos
   arquivos_a_manter=$(ls nexus-*.log.gz -1t | head -n 3)
   # Listar os arquivos restantes (para exclusão)
   arquivos_a_remover=$(ls nexus-*.log.gz -1t | tail -n +4)
   # Remover os arquivos mais antigos
   for arquivo in $arquivos_a_remover
   do
       rm "$arquivo"
       echo "Arquivo $arquivo removido."
   done
else
   echo "O número de arquivos é igual ou inferior a 3. Nenhuma ação necessária."
fi
echo “INICIANDO LIMPEZA request.log”
cd “$NEXUS_LOG_DIR”
pwd
 
numero_arquivos=$(ls request-*.log.gz -1 | wc -l)
if [ "$numero_arquivos" -gt 3 ]; then
   # Listar os arquivos por data e hora e manter os 3 últimos
   arquivos_a_manter=$(ls request-*.log.gz -1t | head -n 3)
  # Listar os arquivos restantes (para exclusão)
   arquivos_a_remover=$(ls request-*.log.gz -1t | tail -n +4)
   # Remover os arquivos mais antigos
   for arquivo in $arquivos_a_remover
   do
       rm "$arquivo"
       echo "Arquivo $arquivo removido."
   done
else
   echo "O número de arquivos é igual ou inferior a 3. Nenhuma ação necessária."
fi
 

echo “INICIANDO LIMPEZA audit.log”
cd “$NEXUS_LOG_DIR/audit”
pwd
numero_arquivos=$(ls audit-*.log.gz -1 | wc -l)
if [ "$numero_arquivos" -gt 3 ]; then
   # Listar os arquivos por data e hora e manter os 3 últimos
   arquivos_a_manter=$(ls audit-*.log.gz -1t | head -n 3)
   # Listar os arquivos restantes (para exclusão)
   arquivos_a_remover=$(ls audit-*.log.gz -1t | tail -n +4)
   # Remover os arquivos mais antigos
   for arquivo in $arquivos_a_remover
   do
       rm "$arquivo"
       echo "Arquivo $arquivo removido."
   done
else
   echo "O número de arquivos é igual ou inferior a 3. Nenhuma ação necessária."
fi
echo "PROCESSO DE LIMPEZA DO LOG  CONCLUIDO"
