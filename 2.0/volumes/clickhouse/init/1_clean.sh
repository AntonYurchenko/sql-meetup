#!/bin/bash

clickhouse client -n <<-EOSQL

    DROP DATABASE IF EXISTS users;;
    CREATE DATABASE users;;

    CREATE TABLE IF NOT EXISTS users.events (
        event_date  Date    COMMENT 'Дата события',
        timestamp   UInt32  COMMENT 'Unix timestamp события',
        user_id     String  COMMENT 'Идентификатор пользователя',
        event       UInt8   COMMENT 'Событие'
    ) ENGINE = MergeTree() PARTITION BY event_date ORDER BY event_date;;

    CREATE TABLE IF NOT EXISTS users.step_sequences (
        event_date  Date          COMMENT 'Дата выполнения последовательности шагов',
        user_id     String        COMMENT 'Идентификатор пользователя',
        steps       Array(UInt8)  COMMENT 'Последовательность шагов',
        duration    UInt32        COMMENT 'Длительность последовательности в секундах',
        isValid     UInt8         COMMENT 'Флаг валидности'
    ) ENGINE = MergeTree() PARTITION BY event_date ORDER BY event_date;;
    

EOSQL