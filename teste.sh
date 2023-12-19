#!/bin/bash

cp /opt/yaman/teste/jmeter.jmx /opt/yaman/scripts

/opt/yaman/jmeter/apache-jmeter-5.5/bin/jmeter -n -t /opt/yaman/scripts/jmeter.jmx -l /opt/yaman/outputs/resultado.csv

cp /opt/yaman/outputs/resultado.csv /opt/yaman/teste

cd /opt/yaman/teste

git config --global user.email "renato.olimelo@gmail.com"
git config --global user.name "Renato Melo"

git add resultado.csv

git commit -m "resultado.csv"

git push https://renatoolimelo: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@github.com/renatoolimelo/teste.git --all

exit 0

