mkdir C:\docker\elastic\data
mkdir C:\docker\logstash\data

# Elastic 
docker run -d --name elastic ^
 -p 9200:9200 -p 9300:9300 ^
 --restart=always ^
 -e "http.host=0.0.0.0" ^
 -e "xpack.security.enabled=true" ^
 -e "discovery.type=single-node" ^
 -v /c/docker/elastic/data:/usr/share/elasticsearch/data ^
docker.elastic.co/elasticsearch/elasticsearch:7.6.0


# Kibana
docker run -d --name kibana --link elastic ^
-p 5601:5601 ^
--restart=always ^
-e "ELASTICSEARCH_URL=http://elastic:9200" ^
-e "XPACK_SECURITY_ENABLED=true" ^
-e "ELASTICSEARCH_USERNAME=elastic" ^
-e "ELASTICSEARCH_PASSWD=changeme" ^
-e XPACK_GRAPH_ENABLED=true ^
-e XPACK_WATCHER_ENABLED=true ^
-e XPACK_ML_ENABLED=true ^
-e XPACK_MONITORING_ENABLED=true ^
-e XPACK_MONITORING_UI_CONTAINER_ELASTICSEARCH_ENABLED ^
docker.elastic.co/kibana/kibana:7.6.0

# LogStash
docker run -d --name logstash --link elastic ^
--restart=always ^
-v /c/docker/logstash/data/conf.d:/etc/logstash/conf.d ^
-e "XPACK.MONITORING.ELASTICSEARCH.URL=http://elastic:9200" ^
docker.elastic.co/logstash/logstash:7.6.0
