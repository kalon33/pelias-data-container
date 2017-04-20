#!/bin/bash

# errors should break the execution
set -e

NAME=google_transit.zip

# Download gtfs stop data
cd $DATA
curl -sS -O http://web.mta.info/developers/data/nyct/subway/$NAME
unzip $NAME

echo '##### Loaded GTFS data'
echo 'OK' >> /tmp/loadresults
