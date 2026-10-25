#!/bin/bash
# Experiment 10 environment: Cassandra in Docker (Killercoda Ubuntu).
docker --version                                   # Step 3: check Docker
docker pull cassandra:5.0                          # Step 4: download image
docker images                                      # Step 5: confirm download
docker run --name cassandra -d -p 9042:9042 cassandra:5.0   # Step 6: start container
docker ps                                          # Step 7: is it running?
# Cassandra needs ~1-2 minutes to start; then open the CQL shell:
docker exec -it cassandra cqlsh                    # Step 8
