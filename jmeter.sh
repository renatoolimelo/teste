#!/bin/bash

if [ $# -ne 1 ]
then
 echo parametros errados
 echo use: $0 "<nome_do_robo>"
 exit 1
fi

#Baixando ultima atualização do GIT
cd /opt/yaman/teste
git pull origin master

#Executando JMeter
/opt/yaman/teste/executa_jmeter.sh

exit 0