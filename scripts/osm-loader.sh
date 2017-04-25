#!/bin/bash

# errors should break the execution
set -e

cd $DATA/openstreetmap

# Download osm data
wget -q -nv -O osm.pbf  https://s3.amazonaws.com/mapzen.odes/ex_qsCMhLYfJTYDxvhBhwdPkwAYrnWBX.osm.pbf 

echo '##### Loaded OSM data'
echo 'OK' >> /tmp/loadresults
