# SQL meetUp (clickhouse)

## v2.0
На синтетических данных рассмотрим следующий функционал clickhouse для работы с массивами:
* Создание массива из столбца таблицы (`groupArray(column)`)
* Сортировка массивов (`arraySort(func, arr)`)
* Создание нового массива на основе старого с помощью функции модификации каждого элемента (`arrayMap(func, arr1, arr2, ...)`)
* Фильтрация массивов (`arrayFilter(func, arr)`)
* Добавление и удаление/элементов в конец/начало массива (`arrayPushBack(arr, element)`, `arrayPushFront(arr, element)`, `arrayPopBack(arr)`, `arrayPopFront(arr)`)
* Развёртывание массива в столбец таблицы (`arrayJoin(arr)`)


## v1.0
* Простые SQL запросы (`SELECT` и `FROM`)
* Применение фильтров (`LIMIT`, `WHERE` и `PREWHERE`)
* Простые агрегации (`GROUP BY` и `ORDER BY`)
* Пересечение таблиц (`INNER`, `LEFT`, `RIGHT` и `FULL OUTER JOIN`)
* Подгрузка данных с другого clickhouse сервера
* Задание для самостоятельной работы на закрепление
