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

function link_others {
    npm link pelias-dbclient
    npm link pelias-wof-admin-lookup
}

set -e

mkdir -p $TOOLS

install_node_project HSLdevcom dbclient

install_node_project pelias schema 1aa457cb0b520bdcf4bd93d57125bf1bf4c74bfa

install_node_project laidig wof-admin-lookup

install_node_project laidig openstreetmap
link_others

install_node_project pelias openaddresses
link_others

install_node_project pelias polylines 
link_others

install_node_project laidig pelias-gtfs  
link_others

install_node_project laidig geonames
link_others

npm cache clean
