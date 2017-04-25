#!/bin/bash

# errors should break the execution
set -e

NAME=google_transit.zip

mkdir -p $DATA/gtfs

# Download gtfs stop data
cd $DATA/gtfs
wget -nv http://web.mta.info/developers/data/nyct/subway/$NAME

echo '##### Loaded GTFS data'
echo 'OK' >> /tmp/loadresults
