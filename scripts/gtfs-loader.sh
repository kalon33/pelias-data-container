#!/bin/bash

# errors should break the execution
set -e

NAME=google_transit.zip

# Download gtfs stop data
cd $DATA
wget -nv http://web.mta.info/developers/data/nyct/subway/$NAME
unzip -d gtfs $NAME

echo '##### Loaded GTFS data'
echo 'OK' >> /tmp/loadresults
