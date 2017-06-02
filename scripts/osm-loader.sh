#!/bin/bash

# errors should break the execution
set -e

cd $DATA/openstreetmap

# Download osm data
wget -q -nv -O osm.pbf https://s3.amazonaws.com/mapzen.odes/ex_DJwv1Zb9GdMA6yJPb1XJE7szYDQa.osm.pbf 
#wget -q -nv -O osm.pbf https://s3.amazonaws.com/metro-extracts.mapzen.com/new-york_new-york.osm.pbf
#wget -q -nv -O osm.pbf https://s3.amazonaws.com/mapzen.odes/ex_CGsZ1bjMkKL3gnqx5DjF3iM6qssMB.osm.pbf

echo '##### Loaded OSM data'
echo 'OK' >> /tmp/loadresults
