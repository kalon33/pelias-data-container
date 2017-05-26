#!/bin/bash

# main Docker script has already created these:
export TOOLS=/mnt/tools
export DATA=/mnt/data
SCRIPTS=$TOOLS/scripts


#=========================================
# Install importers and their dependencies
#=========================================

# note: we cannot run parallel npm installs!

# param1: organization name
# param2: git project name
# param3: optional git commit id
# note: changes cd to new project dir
function install_node_project {
    git clone --single-branch https://github.com/$1/$2 $TOOLS/$2
    cd $TOOLS/$2
    if [ -n "$3" ]; then
        git checkout $3
    fi
    #pelias-geonames needs to run a postinstall command, so unsafe-perm
    npm install -q --unsafe-perm

    #make the package locally available
    npm link
}

set -e

mkdir -p $TOOLS

install_node_project HSLdevcom dbclient

install_node_project pelias schema 1aa457cb0b520bdcf4bd93d57125bf1bf4c74bfa

install_node_project pelias wof-admin-lookup

install_node_project HSLdevcom openstreetmap
npm link pelias-dbclient
npm link pelias-wof-admin-lookup

install_node_project HSLdevcom openaddresses
npm link pelias-dbclient
npm link pelias-wof-admin-lookup

install_node_project pelias polylines 
npm link pelias-dbclient
npm link pelias-wof-admin-lookup

install_node_project laidig pelias-gtfs 
npm link pelias-dbclient
npm link pelias-wof-admin-lookup

install_node_project laidig geonames
npm link pelias-dbclient
npm link pelias-wof-admin-lookup
