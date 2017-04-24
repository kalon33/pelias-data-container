#!/bin/bash

# errors should break the execution
set -e

cd $DATA/openstreetmap

# Download osm data
#wget -nv -O -nc clean.pbf  https://s3.amazonaws.com/mapzen.odes/ex_qsCMhLYfJTYDxvhBhwdPkwAYrnWBX.osm.pbf 

echo '##### Loaded OSM data'
echo 'OK' >> /tmp/loadresults
