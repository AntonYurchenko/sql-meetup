#!/bin/bash

SAMPLES_DIR='/var/samples'

cat ${SAMPLES_DIR}/bank_complaints.tsv | clickhouse client -q "INSERT INTO bank.complaints FORMAT TSVWithNames"
cat ${SAMPLES_DIR}/bank_transactions.tsv | clickhouse client -q "INSERT INTO bank.transactions FORMAT TSVWithNames"
cat ${SAMPLES_DIR}/bank_clients.tsv | clickhouse client -q "INSERT INTO bank.clients FORMAT TSVWithNames"
cat ${SAMPLES_DIR}/ecosystem_mapping.tsv | clickhouse client -q "INSERT INTO ecosystem.mapping FORMAT TSVWithNames"
cat ${SAMPLES_DIR}/mobile_build.tsv | clickhouse client -q "INSERT INTO mobile.build FORMAT TSVWithNames"
cat ${SAMPLES_DIR}/mobile_clients.tsv | clickhouse client -q "INSERT INTO mobile.clients FORMAT TSVWithNames"
cat ${SAMPLES_DIR}/market_place_delivery.tsv | clickhouse client -q "INSERT INTO market_place.delivery FORMAT TSVWithNames"
