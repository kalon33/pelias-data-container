#!/bin/bash

# errors should break the execution
set -e

mkdir -p $DATA/openaddresses
cd $DATA/openaddresses

# Download New York and New Jersey entries from OpenAddresses
curl -sS -O http://results.openaddresses.io/state.txt 
cat state.txt | sed 's/\s\+/\n/g' | grep 'city_of_new_york' | grep openaddresses.io | xargs -I {} -n 1 curl -O {}
cat state.txt | sed 's/\s\+/\n/g' | grep 'us/nj/statewide' | grep openaddresses.io | xargs -I {} -n 1 curl -O {}
ls *.zip | xargs -n 1 unzip -o
rm *.zip README.*

echo '##### Loaded OpenAddresses data'
echo 'OK' >> /tmp/loadresults
