#!/bin/bash

clickhouse client -n <<-EOSQL

    DROP DATABASE IF EXISTS bank;;
    DROP DATABASE IF EXISTS ecosystem;;
    DROP DATABASE IF EXISTS mobile;;
    DROP DATABASE IF EXISTS market_place;;

    CREATE DATABASE bank;;
    CREATE DATABASE ecosystem;;
    CREATE DATABASE mobile;;
    CREATE DATABASE market_place;;

    CREATE TABLE bank.complaints (
        event_date  DateTime,
        userId      FixedString(11),
        text        String
    ) ENGINE = MergeTree() PARTITION BY toYYYYMM(event_date) ORDER BY event_date;;

    CREATE TABLE bank.transactions (
        event_date   DateTime,
        account_out  FixedString(20),
        account_in   FixedString(20),
        value        Float32
    ) ENGINE = MergeTree() PARTITION BY toYYYYMM(event_date) ORDER BY event_date;;

    CREATE TABLE bank.clients (
        userId   FixedString(11), 
        account  FixedString(20),
        phone    FixedString(12), 
        fio      String
    ) ENGINE = MergeTree() ORDER BY userId;;

    CREATE TABLE ecosystem.mapping (
        id                    UInt32,
        bank_id               Nullable(FixedString(11)),
        mobile_user_id        Nullable(FixedString(11)),
        market_plece_user_id  Nullable(FixedString(12))
    ) ENGINE = MergeTree() ORDER BY id;;

    CREATE TABLE mobile.build (
        event_date    DateTime, 
        from_call     FixedString(12), 
        to_call       FixedString(12), 
        duration_sec  UInt32
    ) ENGINE = MergeTree() PARTITION BY toYYYYMM(event_date) ORDER BY event_date;;

    CREATE TABLE mobile.clients (
        client_id  FixedString(11), 
        phone      FixedString(12), 
        fio        String, 
        address    Nullable(String)
    ) ENGINE = MergeTree() ORDER BY client_id;;

    CREATE TABLE market_place.delivery (
        event_date     DateTime, 
        user_id        FixedString(12),
        contact_fio    String,
        contact_phone  FixedString(12),
        address        String
    ) ENGINE = MergeTree() PARTITION BY toYYYYMM(event_date) ORDER BY event_date;;

EOSQL