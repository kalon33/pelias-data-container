#!/bin/bash

# to install the wof cloning tool:
git clone https://github.com/whosonfirst/go-whosonfirst-clone.git wof-clone
cd wof-clone
make deps
make bin
cd ..

# Download Whosonfirst admin lookup data
URL=https://whosonfirst.mapzen.com/bundles
METADIR=meta/
DATADIR=data/
mkdir -p $METADIR
mkdir -p $DATADIR

cd $METADIR

admins=( continent country localadmin locality neighbourhood region borough county)

for target in "${admins[@]}"
do
    echo getting $target metadata
    curl -O -sS $URL/wof-$target-latest.csv
#    if ([ "$target" == 'continent' ] || [ "$target" == 'country' ])
    if ([ "$target" == 'continent' ])
    then
	continue
    else
	echo grepping local data from $target 
	#ny, nj, ct regions
	head -1 wof-$target-latest.csv > temp && cat wof-$target-latest.csv | grep ",1108826385," >> temp && cat wof-$target-latest.csv | grep ",136253037,">> temp && cat wof-$target-latest.csv | grep ",404227465,">> temp || true
	mv temp wof-$target-latest.csv
    fi
done

empty_admins=( continent dependency disputed macrocounty macroregion )

for target in "${empty_admins[@]}"
do
    cp ../empty.csv wof-$target-latest.csv
done

cd ../

for target in "${admins[@]}"
do
    echo getting $target data
    echo $PWD
    ./wof-clone/bin/wof-clone-metafiles -loglevel info -dest $DATADIR $METADIR/wof-$target-latest.csv
done
