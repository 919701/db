--Вывести к каждому самолету класс обслуживания и количество мест этого класса
select aircraft_code,
       fare_conditions,
       count(seat_no) total_seats
from seats
group by aircraft_code,
         fare_conditions
order by aircraft_code,
         fare_conditions;

--Найти 3 самых вместительных самолета (модель + кол-во мест)
select (select model ->> 'en' aircraft_model
        from aircrafts_data
        where seats.aircraft_code = aircrafts_data.aircraft_code),
       count(seat_no) total_seats
from seats
group by aircraft_code
order by total_seats desc
limit 3;

--Вывести код,модель самолета и места не эконом класса для самолета 'Аэробус A321-200' с сортировкой по местам
select distinct aircrafts_data.aircraft_code,
                model ->> 'ru' aircraft_model,
                seat_no,
                fare_conditions
from aircrafts_data,
     seats
where model ->> 'ru' = 'Аэробус A321-200'
  and fare_conditions <> 'Economy'
order by seat_no;

--Вывести города в которых больше 1 аэропорта ( код аэропорта, аэропорт, город)
select airport_code,
       airport_name ->> 'en' airport_name,
       city ->> 'en'
from airports_data
where city ->> 'en' in (select city ->> 'en'
                        from airports_data
                        group by city ->> 'en'
                        having count(*) > 1)
order by city ->> 'en';

-- Найти ближайший вылетающий рейс из Екатеринбурга в Москву, на который еще не завершилась регистрация
select *
from flights_v
where status in ('On Time','Departed')
  and departure_city = 'Екатеринбург'
  and arrival_city = 'Москва'
limit 1;

--Вывести самый дешевый и дорогой билет и стоимость ( в одном результирующем ответе)
(select *
 from ticket_flights
 order by amount desc
 limit 1)
union
(select *
 from ticket_flights
 order by amount asc
 limit 1);

-- Написать DDL таблицы Customers , должны быть поля id , firstName, LastName, email , phone. Добавить ограничения на поля ( constraints) .
CREATE TABLE Customers
(
    Id        serial
        constraint Customers_Id primary key,
    FirstName character varying(30)
        constraint Customers_FirstName not null,
    LastName  character varying(30)
        constraint Customers_LastName not null,
    Email     character varying(30)
        constraint Customers_Email unique check ( Email != '' ),
    Phone     INTEGER
        constraint Customers_Phone unique check ( Phone != '')
);

-- Написать DDL таблицы Orders , должен быть id, customerId,	quantity. Должен быть внешний ключ на таблицу customers + ограничения
CREATE TABLE Orders
(
    Id         serial
        constraint Orders_Id primary key,
    CustomerId integer
        constraint Orders_CustomerId not null,
    Quantity   integer
        constraint Orders_Quantity check ( Quantity >= 0 ) default 0,
    foreign key (CustomerId) references Customers (Id)
);

-- Написать 5 insert в эти таблицы

-- удалить таблицы
drop table customers;

-- Написать свой кастомный запрос ( rus + sql)

