#!/bin/bash

#setando timestamp
timestamp_teste=`date '+%Y-%m-%d_%Hh%Mm%Ss'`

#Baixando ultima atualização do GIT
cd /opt/yaman/teste
git pull origin master

#permissão no robô
chmod 775 /opt/yaman/teste/jmeter.jmx

#copiando o robô para a pasta scripts
cp /opt/yaman/teste/jmeter.jmx /opt/yaman/scripts

#executando Jmeter
/opt/yaman/jmeter/apache-jmeter-5.5/bin/jmeter -j /opt/yaman/outputs/jmeter_${timestamp_teste}.log -n -t /opt/yaman/scripts/jmeter.jmx -l /opt/yaman/outputs/resultado_${timestamp_teste}.csv

#copiando o resultado o jmeter.log para a pasta do GIT
if [ ! -d "/opt/yaman/teste/resultado" ]; then
	mkdir /opt/yaman/teste/resultado
fi
cp /opt/yaman/outputs/resultado_${timestamp_teste}.csv /opt/yaman/teste/resultado
cp /opt/yaman/outputs/jmeter_${timestamp_teste}.log /opt/yaman/teste/resultado

#indo para o diretorio do GIT
cd /opt/yaman/teste

#informando usuario do GIT
git config --global user.email "renato.olimelo@gmail.com"
git config --global user.name "Renato Melo"

#Subindo o arquivo para o git hub
git add ./resultado/resultado_${timestamp_teste}.csv ./resultado/jmeter_${timestamp_teste}.log
git commit -m "resultado_${timestamp_teste}.csv"
git push https://${GIT_USER}:${GIT_PASSWORD}@github.com/renatoolimelo/teste.git --all

exit 0
