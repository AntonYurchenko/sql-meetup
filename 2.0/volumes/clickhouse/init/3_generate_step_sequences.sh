#!/bin/bash

clickhouse client -n <<-EOSQL

INSERT INTO users.step_sequences (event_date, user_id, steps, duration, isValid)
SELECT event_date, user_id, steps, duration, isValid
FROM (
    SELECT
        event_date,
        user_id,

        -- Validation of sequences
        steps = arrayPopFront(range(length(sequences) + 1)) AS isValid,

        -- Extracting steps and calculation of duration for each sequence
        sequences[length(sequences)].2 - sequences[1].2 AS duration,
        arrayMap(t -> t.1, sequences) AS steps,
        arrayJoin(sequences_arr) AS sequences,

        -- Slicing sequences to array of sequences
        arrayMap(a -> arrayFilter(t -> t.1 != 0, a), arrayPopFront(arr2)) AS sequences_arr,
        arrayMap(
            i -> if(
                    i = 1, 
                    array(), 
                    arraySlice(
                        sorted_event_ts, indexes_of_first_step[i - 1], 
                        indexes_of_first_step[i] - indexes_of_first_step[i - 1]
                    )
                ),
            arrayPopFront(range(length(indexes_of_first_step) + 1))
        ) AS arr2,

        -- Searching indexes of first steps for all sequences
        arrayPushBack(arr1, length(sorted_event_ts) + 1) AS indexes_of_first_step,
        arrayFilter(
            i -> i > 0,
            arrayMap(t -> if(t.1 = 1, indexOf(sorted_event_ts, t), 0), sorted_event_ts)
        ) AS arr1,

        -- Sorting array of events by timestamp
        arraySort(t -> t.2, event_ts) AS sorted_event_ts,

        -- Grouping events and them timestamps to array of tuples
        groupArray((event, timestamp)) AS event_ts

    FROM users.events
    GROUP BY event_date, user_id
)

EOSQL