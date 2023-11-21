#!/bin/bash
# Script de limpeza dos logs do Nexus

#Function LimpaArquivos
function LimpaArquivos () {

	local DIR=$1
	local ARQ=$2

	cd $DIR
	pwd

	numero_arquivos=$(ls $ARQ-*.log.gz -1 | wc -l)
	if [ "$numero_arquivos" -gt 3 ]; then
	   # Listar os arquivos por data e hora e manter os 3 últimos
	   arquivos_a_manter=$(ls $ARQ-*.log.gz -1t | head -n 3)
	   # Listar os arquivos restantes (para exclusão)
	   arquivos_a_remover=$(ls $ARQ-*.log.gz -1t | tail -n +4)
	   # Remover os arquivos mais antigos
	   for arquivo in $arquivos_a_remover
	   do
		   rm "$arquivo"
		   echo "Arquivo $arquivo removido."
	   done
	else
	   echo “O número de arquivos $ARQ.log é igual ou inferior a 3. Nenhuma ação necessária.”
	fi
}


NEXUS_LOG_DIR=/opt/nexusdata/nexus3/log/

echo “INICIANDO LIMPEZA nexus.log”

ARQUIVO=nexus

LimpaArquivos $NEXUS_LOG_DIR $ARQUIVO


echo “INICIANDO LIMPEZA request.log”

ARQUIVO=request

LimpaArquivos $NEXUS_LOG_DIR $ARQUIVO
 

echo “INICIANDO LIMPEZA audit.log”

NEXUS_LOG_DIR=/opt/nexusdata/nexus3/log/audit

ARQUIVO=audit

LimpaArquivos $NEXUS_LOG_DIR $ARQUIVO
 
echo "PROCESSO DE LIMPEZA DO LOG  CONCLUIDO"
