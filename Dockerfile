FROM elasticsearch:2.3
MAINTAINER Reittiopas version: 0.1

RUN apt-get update && \
    apt-get install -y --no-install-recommends git unzip python python-pip python-dev build-essential gdal-bin rlwrap

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get install -y --no-install-recommends nodejs


# Finalize elasticsearch installation
ADD config/elasticsearch.yml /usr/share/elasticsearch/config/

# Add elastisearch-head plugin for browsing ElasticSearch data
RUN chmod +wx /usr/share/elasticsearch/plugins/
RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head
RUN /usr/share/elasticsearch/bin/plugin install analysis-icu

RUN mkdir -p /var/lib/elasticsearch/pelias_data \
  && chown -R elasticsearch:elasticsearch /var/lib/elasticsearch/pelias_data

ENV ES_HEAP_SIZE 4g

# Download and index data and do cleanup for temp data + packages
RUN mkdir -p /mnt/tools/scripts
ADD scripts/*.sh /mnt/tools/scripts/
RUN /bin/bash -c "source /mnt/tools/scripts/install-node-deps.sh"

ADD pelias.json /root/pelias.json

RUN mkdir -p /mnt/data
ADD new_york.polylines /mnt/data

RUN mkdir -p /mnt/data/openstreetmap
ADD clean.osm.pbf /mnt/data/openstreetmap

RUN mkdir -p /mnt/data/whosonfirst
ADD wof_data /mnt/data/whosonfirst/wof_data

RUN /bin/bash -c "source /mnt/tools/scripts/getdata.sh"

RUN chmod -R a+rwX /var/lib/elasticsearch/ \
  && chown -R 9999:9999 /var/lib/elasticsearch/

ENV ES_HEAP_SIZE 2g

ENTRYPOINT ["elasticsearch"]

USER 9999
