#!/bin/bash

# errors should break the execution
set -e

# param: zip name containing gtfs data
function import_gtfs {
    unzip -o $1
    prefix=$(echo $1 | sed 's/.zip//g')
    prefix=${prefix^^}
    node $TOOLS/pelias-gtfs/import -d $DATA/gtfs --prefix=$prefix
}

cd $DATA/gtfs
targets=(`ls *.zip`)
for target in "${targets[@]}"
do
    import_gtfs $target
done
echo '###### gtfs done'

#import openaddresses data
cd  $TOOLS/openaddresses

bin/parallel 2 --language=en --merge --merge-fields=name
echo '###### openaddresses/en done'

echo 'OK' >> /tmp/indexresults
