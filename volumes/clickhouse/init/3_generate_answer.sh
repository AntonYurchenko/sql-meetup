#!/bin/bash

clickhouse client -n <<-EOSQL

-- Client profile
DROP TABLE IF EXISTS default.client_profile;;
CREATE VIEW default.client_profile AS
SELECT userId, fio, account, phone, mobile_user_id, market_plece_user_id 
FROM (
    SELECT 
        userId, fio, account, phone
    FROM bank.complaints ALL INNER JOIN bank.clients USING userId
) ALL INNER JOIN ecosystem.mapping ON userId = bank_id;;

-- Transactions of clients
DROP TABLE IF EXISTS default.client_transactions;;
CREATE VIEW default.client_transactions AS
SELECT userId, fio, account, account_out AS account_of_receiver, value, event_date
FROM default.client_profile ALL INNER JOIN bank.transactions ON account = account_out;;

-- Calls of client
DROP TABLE IF EXISTS default.client_calls;;
CREATE VIEW default.client_calls AS
SELECT userId, fio, from_call AS incoming_call, duration_sec, event_date
FROM default.client_profile ALL INNER JOIN mobile.build ON phone = to_call;;

-- Collection information by phone
DROP TABLE IF EXISTS default.info_by_phone;;
CREATE VIEW default.info_by_phone AS
SELECT phone, fio, address, bank_id, mobile_user_id, market_plece_user_id
FROM (
    SELECT client_id AS mobile_client_id, phone, clients.fio AS fio, address
    FROM default.client_calls ALL INNER JOIN mobile.clients ON incoming_call = phone
) ALL INNER JOIN ecosystem.mapping ON mobile_client_id = mobile_user_id;;

-- Search information in another services of ecosystem
DROP TABLE IF EXISTS default.answer;;
CREATE VIEW default.answer AS
SELECT phone, contact_phone, fio, contact_fio, delivery.address, event_date
FROM default.info_by_phone ALL INNER JOIN market_place.delivery ON market_plece_user_id = user_id;;

EOSQL