#!/bin/bash

#setando timestamp
timestamp_teste=`date '+%Y-%m-%d_%Hh%Mm%Ss'`

#permissão no robô
chmod 775 /opt/yaman/teste/jmeter.jmx

#copiando o robô para a pasta scripts
cp /opt/yaman/teste/jmeter.jmx /opt/yaman/scripts

#executando Jmeter
/opt/yaman/jmeter/apache-jmeter-5.5/bin/jmeter -j /opt/yaman/outputs/jmeter_${timestamp_teste}.log -n -t /opt/yaman/scripts/jmeter.jmx -l /opt/yaman/outputs/resultado_${timestamp_teste}.csv

#copiando o resultado o jmeter.log para a pasta do GIT
cp /opt/yaman/outputs/resultado_${timestamp_teste}.csv /opt/yaman/teste
cp /opt/yaman/outputs/jmeter_${timestamp_teste}.log /opt/yaman/teste

#indo para o diretorio do GIT
cd /opt/yaman/teste

#informando usuario do GIT
git config --global user.email "renato.olimelo@gmail.com"
git config --global user.name "Renato Melo"

#Subindo o arquivo para o git hub
git add resultado_${timestamp_teste}.csv jmeter_${timestamp_teste}.log
git commit -m "resultado_${timestamp_teste}.csv"
git push https://${GIT_USER}:${GIT_PASSWORD}@github.com/renatoolimelo/teste.git --all

exit 0
