--Вывести к каждому самолету класс обслуживания и количество мест этого класса
select aircraft_code, fare_conditions, count(seat_no) total_seats
from seats
group by aircraft_code, fare_conditions
order by aircraft_code, fare_conditions;

--Найти 3 самых вместительных самолета (модель + кол-во мест)
select (select model ->> 'en'
        from aircrafts_data
        where seats.aircraft_code = aircrafts_data.aircraft_code),
       count(seat_no) total_seats
from seats
group by aircraft_code
order by total_seats desc
limit 3;

--Вывести код,модель самолета и места не эконом класса для самолета 'Аэробус A321-200' с сортировкой по местам
select seats.aircraft_code,
       seat_no,
       fare_conditions,
       aircrafts_data.model ->> 'ru' model_aircraft
from seats,
     aircrafts_data
where fare_conditions != 'Economy'
  and model ->> 'ru' = 'Аэробус A321-200'
order by seat_no;

--Вывести города в которых больше 1 аэропорта ( код аэропорта, аэропорт, город)
select airport_code,airport_name->>'en' airport_name,city->>'en'
from airports_data
order by city;

-- Найти ближайший вылетающий рейс из Екатеринбурга в Москву, на который еще не завершилась регистрация

--Вывести самый дешевый и дорогой билет и стоимость ( в одном результирующем ответе)

-- Написать DDL таблицы Customers , должны быть поля id , firstName, LastName, email , phone. Добавить ограничения на поля ( constraints) .

-- Написать DDL таблицы Orders , должен быть id, customerId,	quantity. Должен быть внешний ключ на таблицу customers + ограничения

-- Написать 5 insert в эти таблицы

-- удалить таблицы

-- Написать свой кастомный запрос ( rus + sql)

