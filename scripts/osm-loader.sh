#!/bin/bash

# errors should break the execution
set -e

mkdir -p $DATA/openstreetmap
cd $DATA/openstreetmap

# Download osm data
wget -nv  https://s3.amazonaws.com/mapzen.odes/ex_qsCMhLYfJTYDxvhBhwdPkwAYrnWBX.osm.pbf 

echo '##### Loaded OSM data'
echo 'OK' >> /tmp/loadresults
