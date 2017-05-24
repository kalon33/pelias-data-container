#!/bin/bash

# errors should break the execution
set -e

echo '##### downloading US geonames'
mkdir -p $DATA/geonames
cd $DATA/geonames
curl -sS -O http://download.geonames.org/export/dump/US.zip
unzip -c US.zip US.txt | grep -e 'US[[:space:]]*N[Y|J]' > US.txt

echo 'OK' >> /tmp/loadresults
