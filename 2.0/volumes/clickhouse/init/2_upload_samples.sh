#!/bin/bash

SAMPLES_DIR='/var/samples'

cat ${SAMPLES_DIR}/events.tsv | clickhouse client -q "INSERT INTO users.events FORMAT TSVWithNames"
