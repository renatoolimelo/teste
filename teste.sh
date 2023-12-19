#!/bin/bash

timestamp_teste=`date '+%Y-%m-%d_%Hh%Mm%Ss'`

chmod 775 /opt/yaman/teste/jmeter.jmx

cp /opt/yaman/teste/jmeter.jmx /opt/yaman/scripts

/opt/yaman/jmeter/apache-jmeter-5.5/bin/jmeter -j /opt/yaman/outputs/jmeter_${timestamp_teste}.log -n -t /opt/yaman/scripts/jmeter.jmx -l /opt/yaman/outputs/resultado_${timestamp_teste}.csv

cp /opt/yaman/outputs/resultado_${timestamp_teste}.csv /opt/yaman/teste
cp /opt/yaman/outputs/jmeter_${timestamp_teste}.log /opt/yaman/teste

cd /opt/yaman/teste

git config --global user.email "renato.olimelo@gmail.com"
git config --global user.name "Renato Melo"

git add resultado_${timestamp_teste}.csv jmeter_${timestamp_teste}.log

git commit -m "resultado_${timestamp_teste}.csv"

git push https://${GIT_USER}:${GIT_PASSWORD}@github.com/renatoolimelo/teste.git --all

exit 0
