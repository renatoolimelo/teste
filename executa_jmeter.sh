#!/bin/bash

if [ $# -ne 3 ]
then
 echo parametros errados
 echo use: $0 "<nome_do_robo> <GIT_USER> <GIT_PASSWORD>"
 exit 1
fi

NOME_ROBO=$1
GIT_USER=$2
GIT_PASSWORD=$3

#Baixando ultima atualização do GIT
cd /opt/yaman/teste
git pull origin master

#setando timestamp
TIMESTAMP_TESTE=`date '+%Y-%m-%d_%Hh%Mm%Ss'`

#permissão no robô
if [ ! -e "/opt/yaman/teste/${NOME_ROBO}.jmx" ] ; then
	echo "o robo ${NOME_ROBO}.jmx não está no diretorio /opt/yaman/teste"
	exit 1
fi
chmod 775 /opt/yaman/teste/${NOME_ROBO}.jmx

#copiando o robô e massas para a pasta scripts
cp /opt/yaman/teste/${NOME_ROBO}.jmx /opt/yaman/scripts
if [ -d "/opt/yaman/teste/massa_teste" ]; then
	if [ `ls /opt/yaman/teste/massa_teste | wc -l` -gt 0 ]; then
		cp /opt/yaman/teste/massa_teste/* /opt/yaman/scripts
	fi
fi

#executando Jmeter
/opt/yaman/jmeter/apache-jmeter-5.5/bin/jmeter -j /opt/yaman/outputs/jmeter_${TIMESTAMP_TESTE}.log -n -t /opt/yaman/scripts/${NOME_ROBO}.jmx -l /opt/yaman/outputs/${NOME_ROBO}_${TIMESTAMP_TESTE}.csv

#copiando o resultado e o jmeter.log para a pasta do GIT
if [ ! -d "/opt/yaman/teste/resultado" ]; then
	mkdir /opt/yaman/teste/resultado
fi
cp /opt/yaman/outputs/${NOME_ROBO}_${TIMESTAMP_TESTE}.csv /opt/yaman/teste/resultado
cp /opt/yaman/outputs/jmeter_${TIMESTAMP_TESTE}.log /opt/yaman/teste/resultado

#indo para o diretorio do GIT
cd /opt/yaman/teste

#informando usuario do GIT
git config --global user.email "renato.olimelo@gmail.com"
git config --global user.name "Renato Melo"

#Subindo o arquivo para o git hub
git add ./resultado/${NOME_ROBO}_${TIMESTAMP_TESTE}.csv ./resultado/jmeter_${TIMESTAMP_TESTE}.log
git commit -m "${NOME_ROBO}_${TIMESTAMP_TESTE}.csv"
git push https://${GIT_USER}:${GIT_PASSWORD}@github.com/renatoolimelo/teste.git --all

exit 0
