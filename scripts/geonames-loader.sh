#!/bin/bash

# errors should break the execution
set -e

echo '##### downloading US geonames'
mkdir -p $DATA/geonames
cd $DATA/geonames
curl -sS -O http://download.geonames.org/export/dump/FR.zip
#unzip -c US.zip US.txt | grep -e 'US[[:space:]]*N[Y|J]' > US.txt
#zip -9u US.zip US.txt

echo 'OK' >> /tmp/loadresults
