#!/bin/bash

cp /opt/yaman/teste/jmeter.jmx /opt/yaman/scripts

/opt/yaman/jmeter/apache-jmeter-5.5/bin/jmeter -n -t /opt/yaman/scripts/jmeter.jmx -l /opt/yaman/outputs/resultado.csv

exit 0
