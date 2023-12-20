#!/bin/bash

if [ $# -ne 1 ]
then
 echo parametros errados
 echo use: $0 "<nome_do_robo>"
 exit 1
fi

NOME_ROBO=$1

#Baixando ultima atualização do GIT
cd /opt/yaman/teste
git pull origin master

#Executando JMeter
/opt/yaman/teste/executa_jmeter.sh ${NOME_ROBO=$1}

exit 0