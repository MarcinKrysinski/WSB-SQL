DROP TABLE IF EXISTS lecture;

CREATE TABLE lecture
(
    id            SERIAL PRIMARY KEY,
    room_number   INTEGER,
    teacher_name  VARCHAR(150),
    teacher_email VARCHAR(100),
    start_time    TIMESTAMP,
    end_time      TIMESTAMP,
    is_lab        BOOLEAN,
    name          VARCHAR(255)
);

INSERT INTO lecture (room_number, teacher_name, teacher_email, start_time, end_time, is_lab, name)
VALUES (1, 'Kasia Nowak', 'knowak@db.pl', '2020-10-26 11:30', '2020-10-26 12:30', TRUE, 'SQL'),
       (2, 'Jan Kowalski', 'jkowalski@db.pl', '2020-10-27 11:30', '2020-10-27 13:30', FALSE, 'Java'),
       (3, 'Emilia Kot', 'ekot@db.pl', '2020-10-27 14:00', '2020-10-27 16:30', FALSE, 'CSS'),
       (4, 'Jan Kowalski', 'jkowalski@db.pl', '2020-10-29 07:00', '2020-10-29 11:00', FALSE, 'HTML'),
       (1, 'Kasia Nowak', 'knowak@db.pl', '2020-10-26 11:00', '2020-10-26 11:30', TRUE, 'Testy');


SELECT *
from lecture;


INSERT INTO lecture (room_number, teacher_name, teacher_email, start_time, end_time, is_lab)
VALUES (1, 'Kasia Nowak', 'knowak@db.pl', '2020-10-26 11:30', '2020-10-26 12:30', TRUE);
-------------------------------------------------------

DROP TABLE IF EXISTS lecture;

DROP TABLE IF EXISTS room;

DROP TABLE IF EXISTS teacher;

-- CREATE TABLE teacher
-- (
--     id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     email VARCHAR(100),
--     name VARCHAR(150)
-- );
-- INSERT INTO teacher (email, name)
-- SELECT DISTINCT (teacher_email, teacher_name) teacher_email, teacher_name
-- FROM lecture;
--
-- SELECT *
-- from teacher;

-- Nauczyciele

CREATE TABLE teacher
(
    email VARCHAR(100) PRIMARY KEY,
    name  VARCHAR(150),
    title VARCHAR(15)
);

INSERT INTO teacher (email, name, title)
VALUES ('knowak@db.pl', 'Kasia Nowak', 'mgr inż.'),
       ('jkowalski@db.pl', 'Jan Kowalski', 'mgr'),
       ('ekot@db.pl', 'Emilia Kot', 'prof. nadzw.'),
       ('emazur@db.pl', 'Ewa Mazur', NULL);

-- Sale

CREATE TABLE room
(
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_number     VARCHAR(4),
    building        VARCHAR(20),
    is_lab          BOOLEAN,
    number_of_seats INTEGER
);

INSERT INTO room (room_number, building, is_lab, number_of_seats)
VALUES ('1', 'A', TRUE, 10),
       ('2B', 'A', FALSE, 50),
       ('3', 'B', FALSE, 30),
       ('4', 'A', FALSE, 30);

-- Zajęcia

CREATE TABLE lecture
(
    id            INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    teacher_email VARCHAR(100) REFERENCES teacher (email),
    room_id       INTEGER REFERENCES room (id),
    start_time    TIMESTAMP,
    end_time      TIMESTAMP,
    name          VARCHAR(255)
);

INSERT INTO lecture (teacher_email, room_id, start_time, end_time, name)
VALUES ('knowak@db.pl', 1, '2020-10-26 11:30', '2020-10-26 12:30', 'SQL'),
       ('jkowalski@db.pl', 2, '2020-10-27 11:30', '2020-10-27 13:30', 'Java'),
       ('ekot@db.pl', 3, '2020-10-27 14:00', '2020-10-27 16:30', 'CSS'),
       ('jkowalski@db.pl', 4, '2020-10-29 07:00', '2020-10-29 11:00', 'HTML'),
       ('knowak@db.pl', 1, '2020-10-26 11:00', '2020-10-26 11:30', 'Testy');


select t.name,
       t.title,
       r.room_number,
       l.start_time,
       l.name
from lecture l, room r, teacher t
where l.room_id = r.id
and l.teacher_email = t.email
and r.room_number in ('1', '3') and l.name != 'Testy';

SELECT
    r.room_number, l.name
FROM
    room r
        RIGHT
            JOIN
    lecture l
    ON
            r.id = l.room_id;

SELECT
    r.room_number, l.name
FROM
    room r
        LEFT
            JOIN
    lecture l
    ON
            r.id = l.room_id;

SELECT
    t.name, r.room_number
FROM
    room r
        CROSS
            JOIN
    teacher t
ORDER
    BY
    t.name, r.room_number;

Select t.name,
       t.title,
       r.room_number,
       l.start_time,
       l.end_time,
       l.name
from lecture l
         join teacher t
              on l.teacher_email = t.email
         join room r
              on l.room_id = r.id
where r.room_number in ('1', '3')
  and l.name != 'Testy';


select *
from lecture;
select *
from teacher;


-- Homework 1

-- Dane do zadania
DROP TABLE IF EXISTS lecture;

DROP TABLE IF EXISTS room;

DROP TABLE IF EXISTS teacher;

-- Nauczyciele

CREATE TABLE teacher
(
    email VARCHAR(100) PRIMARY KEY,
    name  VARCHAR(150),
    title VARCHAR(15)
);

INSERT INTO teacher (email, name, title)
VALUES ('knowak@db.pl', 'Kasia Nowak', 'mgr inż.'),
       ('jkowalski@db.pl', 'Jan Kowalski', 'mgr'),
       ('ekot@db.pl', 'Emilia Kot', 'prof. nadzw.'),
       ('emazur@db.pl', 'Ewa Mazur', NULL);

-- Sale

CREATE TABLE room
(
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_number     VARCHAR(4),
    building        VARCHAR(20),
    is_lab          BOOLEAN,
    number_of_seats INTEGER
);

INSERT INTO room (room_number, building, is_lab, number_of_seats)
VALUES ('1', 'A', TRUE, 10),
       ('2B', 'A', FALSE, 50),
       ('3', 'B', FALSE, 30),
       ('4', 'A', FALSE, 30);

-- Zajęcia

CREATE TABLE lecture
(
    id            INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    teacher_email VARCHAR(100) REFERENCES teacher (email),
    room_id       INTEGER REFERENCES room (id),
    start_time    TIMESTAMP,
    end_time      TIMESTAMP,
    name          VARCHAR(255)
);

INSERT INTO lecture (teacher_email, room_id, start_time, end_time, name)
VALUES ('knowak@db.pl', 1, '2020-10-26 11:30', '2020-10-26 12:30', 'SQL'),
       ('jkowalski@db.pl', 2, '2020-10-27 11:30', '2020-10-27 13:30', 'Java'),
       ('ekot@db.pl', 3, '2020-10-27 14:00', '2020-10-27 16:30', 'CSS'),
       ('jkowalski@db.pl', 4, '2020-10-29 07:00', '2020-10-29 11:00', 'HTML'),
       ('knowak@db.pl', 1, '2020-10-26 11:00', '2020-10-26 11:30', 'Testy');


-- Rozwiązanie zadnaia 1
--1
select *
from teacher;
update teacher
set title = 'dr'
where teacher.name = 'Kasia Nowak';
--2
select *
from lecture;
update lecture
set name = 'SQL - zajęcia odwołane'
where lecture.name = 'SQL';
delete
from lecture
where lecture.name = 'SQL';
--3
insert into room(room_number, building, is_lab, number_of_seats)
values ('10D', 'B', true, 20);

select id
from room
where room_number = '10D'
  and building = 'B';

UPDATE lecture
set room_id = 5
from room r
         join lecture l
              on l.room_id = r.id
where r.id = l.room_id
  and l.name = 'Java';

--- najslepsze rozwiazanie
UPDATE lecture
set room_id = (select id
               from room
               where room_number = '10D'
                 and building = 'B')
where name = 'Java';

--4
UPDATE room
SET number_of_seats = number_of_seats / 2;


select *
from room;


--Homewrok 2
select *
from lecture;
select start_time                                                                         as orginal,
       DATE_PART('hour', cast(end_time as time)::time - cast(start_time as time)::time) * 60 +
       DATE_PART('minute', cast(end_time as time)::time - cast(start_time as time)::time) as duration
from lecture;

SELECT DATE_PART('hour', cast(end_time as time)::time - cast(start_time as time)::time) * 60 +
       DATE_PART('minute', cast(end_time as time)::time - cast(start_time as time)::time)
from lecture;


Select l.name                                                                             as class_name,
       r.room_number                                                                      as room_number,
       t.name                                                                             as teacher,
       l.start_time                                                                       as start_time,
       DATE_PART('hour', cast(end_time as time)::time - cast(start_time as time)::time) * 60 +
       DATE_PART('minute', cast(end_time as time)::time - cast(start_time as time)::time) as duration
from lecture l
         join teacher t
              on l.teacher_email = t.email
         join room r
              on l.room_id = r.id
order by start_time;

-----------------------------------------------------------------------

DROP TABLE IF EXISTS lecture CASCADE;

DROP TABLE IF EXISTS room;

DROP TABLE IF EXISTS teacher;

-- Nauczyciele

CREATE TABLE teacher
(
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    name  VARCHAR(150)        NOT NULL,
    title VARCHAR(15)
);

INSERT INTO teacher (email, name, title)
VALUES ('knowak@db.pl', 'Kasia Nowak', 'mgr inż.'),
       ('jkowalski@db.pl', 'Jan Kowalski', 'mgr'),
       ('ekot@db.pl', 'Emilia Kot', 'prof. nadzw.'),
       ('amarek@db.pl', 'Adam Marek', 'mgr inż.'),
       ('amazur@db.pl', 'Anna Mazur', 'dr inż.'),
       ('jkowal@db.pl', 'Jakub Kowal', 'dr'),
       ('emazur@db.pl', 'Ewa Mazur', NULL);

-- Sale

CREATE TABLE room
(
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_number     VARCHAR(4)  NOT NULL,
    building        VARCHAR(20) NOT NULL,
    is_lab          BOOLEAN     NOT NULL,
    number_of_seats INTEGER     NOT NULL CHECK ( number_of_seats > 0 ),
    UNIQUE (room_number, building)
);

INSERT INTO room (room_number, building, is_lab, number_of_seats)
VALUES ('1', 'A', TRUE, 10),
       ('2B', 'A', FALSE, 50),
       ('3', 'B', FALSE, 30),
       ('10', 'B', FALSE, 30),
       ('6', 'B', FALSE, 20),
       ('2', 'B', FALSE, 20),
       ('3', 'A', TRUE, 40),
       ('13', 'B', TRUE, 30),
       ('2D', 'B', FALSE, 10),
       ('12', 'B', FALSE, 40),
       ('5', 'B', FALSE, 100),
       ('4', 'A', FALSE, 30);

-- Zajęcia

CREATE TABLE lecture
(
    id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    teacher_id INTEGER REFERENCES teacher (id) NOT NULL,
    room_id    INTEGER REFERENCES room (id)    NOT NULL,
    start_time TIMESTAMP                       NOT NULL,
    end_time   TIMESTAMP                       NOT NULL,
    name       VARCHAR(255)                    NOT NULL,
    CHECK ( start_time < end_time )
);

INSERT INTO lecture (teacher_id, room_id, start_time, end_time, name)
VALUES ((SELECT id FROM teacher WHERE email = 'knowak@db.pl'), (SELECT id FROM room WHERE room_number = '1'),
        '2020-10-26 11:30', '2020-10-26 12:30', 'SQL'),
       ((SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '2B'),
        '2020-10-27 11:30', '2020-10-27 13:30', 'Java'),
       ((SELECT id FROM teacher WHERE email = 'ekot@db.pl'),
        (SELECT id FROM room WHERE room_number = '3' AND building = 'A'),
        '2020-10-27 14:00', '2020-10-27 16:30', 'CSS'),
       ((SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '4'),
        '2020-10-29 07:00', '2020-10-29 11:00', 'HTML'),
       ((SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '2B'),
        '2020-10-27 11:30', '2020-10-27 13:30', 'Java'),
       ((SELECT id FROM teacher WHERE email = 'ekot@db.pl'),
        (SELECT id FROM room WHERE room_number = '3' AND building = 'B'),
        '2020-10-27 14:00', '2020-10-27 16:30', 'CSS'),
       ((SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '5'),
        '2020-10-29 07:00', '2020-12-19 11:00', 'HTML'),
       ((SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '2B'),
        '2020-10-27 11:30', '2020-12-24 13:30', 'Java'),
       ((SELECT id FROM teacher WHERE email = 'ekot@db.pl'), (SELECT id FROM room WHERE room_number = '13'),
        '2020-10-27 14:00', '2020-12-02 16:30', 'CSS'),
       ((SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '4'),
        '2020-10-29 07:00', '2020-12-02 11:00', 'HTML'),
       ((SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '2D'),
        '2020-10-27 11:30', '2020-12-01 13:30', 'Java'),
       ((SELECT id FROM teacher WHERE email = 'ekot@db.pl'), (SELECT id FROM room WHERE room_number = '5'),
        '2020-10-27 14:00', '2020-11-06 16:30', 'SQL'),
       ((SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '6'),
        '2020-10-29 07:00', '2020-11-05 11:00', 'HTML'),
       ((SELECT id FROM teacher WHERE email = 'knowak@db.pl'), (SELECT id FROM room WHERE room_number = '10'),
        '2020-10-26 11:00', '2020-11-05 11:30', 'SQL');


select name      AS teacher_Name,
       (select extract(EPOCH FROM sum((l.end_time - l.start_time)) / 60)
        from lecture l
        where l.teacher_id = teacher.id
        LIMIT 1) AS sum_of_minutes
from teacher
order by sum_of_minutes desc NULLS LAST;


SELECT t.name,
       sum(extract(EPOCH FROM (l.end_time - l.start_time)) / 60) AS sum_of_minutes
FROM lecture l
         right JOIN teacher t
                    ON l.teacher_id = t.id
GROUP BY t.name
ORDER BY sum_of_minutes DESC NULLS LAST;

------------------------------------------


-- CREATE OR REPLACE FUNCTION get_room_label(building varchar, room_number varchar) RETURNS varchar AS
-- $$
-- BEGIN
--     return room_number || ' (' || building || ')';
-- END;
-- $$ LANGUAGE plpgsql;

drop function if exists get_room_label(building VARCHAR, room_number VARCHAR);

CREATE OR REPLACE FUNCTION get_room_label(building VARCHAR, room_number VARCHAR) RETURNS VARCHAR AS
$$
BEGIN
    RETURN room_number || ' (' || building || ')';
END;
$$ LANGUAGE plpgsql;


SELECT get_room_label(building, room_number)
FROM room;


create table animal(
    id integer generated always as identity primary key,
    name varchar(150) unique not null,
    species varchar(150) not null,
    age_in_months integer check (age_in_months >0 ),
    wieght decimal check (wieght >0),
    carnivorous boolean not null default false
);

insert into animal (name, age_in_months, wieght, carnivorous)
values ('Test',NULL,80.401, false);
