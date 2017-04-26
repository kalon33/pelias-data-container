#!/bin/bash

# errors should break the execution
set -e -x

mkdir -p $DATA/gtfs

gtfsFiles=(
    "http://web.mta.info/developers/data/nyct/subway/google_transit.zip"
    "http://web.mta.info/developers/data/nyct/bus/google_transit_bronx.zip"
    "http://web.mta.info/developers/data/nyct/bus/google_transit_brooklyn.zip"
    "http://web.mta.info/developers/data/nyct/bus/google_transit_manhattan.zip"
    "http://web.mta.info/developers/data/nyct/bus/google_transit_queens.zip"
    "http://web.mta.info/developers/data/nyct/bus/google_transit_staten_island.zip"
    #of course everything is named google_transit.zip
    "http://web.mta.info/developers/data/lirr/google_transit.zip"
    "http://web.mta.info/developers/data/mnr/google_transit.zip"
    "http://web.mta.info/developers/data/busco/google_transit.zip"
    "http://data.trilliumtransit.com/gtfs/path-nj-us/path-nj-us.zip"
    "https://dl.dropboxusercontent.com/u/47217822/rail_data(1).zip"
    "https://dl.dropboxusercontent.com/u/47217822/bus_data(2).zip" 
)

# Download gtfs stop data
cd $DATA/gtfs

for f in "${gtfsFiles[@]}"
    do
        IFS='/' read -r -a urlarray <<< "$f"
        #disambiguate google_transit.zip to google_transit_X.zip
        outfile="${urlarray[-1]%.zip}_${urlarray[-2]}.zip"
        wget -nv -NS $f -O $outfile
done

#empty translations.txt 
echo "trans_id,lang,translation" >> translations.txt

for NAME in *.zip; do
	zip -uq $NAME translations.txt
done

echo '##### Loaded GTFS data'
echo 'OK' >> /tmp/loadresults
