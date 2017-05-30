#!/bin/bash

# this import script indexes polylines and osm data

# errors should break the execution
set -e

node $TOOLS/polylines/bin/cli.js --config --db
echo '###### polylines done'

echo '###### indexing OSM'
node $TOOLS/openstreetmap/index
echo '###### openstreetmap done'

echo 'OK' >> /tmp/indexresults
