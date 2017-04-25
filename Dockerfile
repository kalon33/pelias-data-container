FROM elasticsearch:2.3
MAINTAINER Reittiopas version: 0.1

RUN apt-get update -q && \
    apt-get install -yq --no-install-recommends git unzip python python-pip python-dev build-essential gdal-bin rlwrap && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get install -yq --no-install-recommends nodejs && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/*


# Finalize elasticsearch installation
ADD config/elasticsearch.yml /usr/share/elasticsearch/config/

# Add elastisearch-head plugin for browsing ElasticSearch data
RUN chmod +wx /usr/share/elasticsearch/plugins/
RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head && \
  /usr/share/elasticsearch/bin/plugin install analysis-icu

RUN mkdir -p /var/lib/elasticsearch/pelias_data \
  && chown -R elasticsearch:elasticsearch /var/lib/elasticsearch/pelias_data

ENV ES_HEAP_SIZE 4g

#fewer layers
RUN mkdir -p /mnt/tools/install && \
    mkdir -p /mnt/tools/scripts && \
    mkdir -p /mnt/data && \
    mkdir -p /mnt/data/openstreetmap && \
    mkdir -p /mnt/data/whosonfirst

#moved install script to its own directory for caching
ADD install/*.sh /mnt/tools/install/
RUN /bin/bash -c "source /mnt/tools/install/install-node-deps.sh"

# Download and index data and do cleanup for temp data + packages
ADD scripts/*.sh /mnt/tools/scripts/

ADD pelias.json /root/pelias.json

ADD new_york.polylines /mnt/data

#ADD clean.osm.pbf /mnt/data/openstreetmap/osm.pbf     

ADD wof_data /mnt/data/whosonfirst/wof_data

RUN /bin/bash -c "source /mnt/tools/scripts/getdata.sh"

RUN chmod -R a+rwX /var/lib/elasticsearch/ \
  && chown -R 9999:9999 /var/lib/elasticsearch/

ENV ES_HEAP_SIZE 2g

ENTRYPOINT ["elasticsearch"]

USER 9999
