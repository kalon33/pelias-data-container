#!/bin/bash

# errors should break the execution
set -e

NAME=google_transit.zip

mkdir -p $DATA/gtfs

# Download gtfs stop data
cd $DATA/gtfs
wget -nv http://web.mta.info/developers/data/nyct/subway/$NAME

#empty translations.txt 
echo "trans_id,lang,translation" >> translations.txt
zip -u $name translations.txt

echo '##### Loaded GTFS data'
echo 'OK' >> /tmp/loadresults
