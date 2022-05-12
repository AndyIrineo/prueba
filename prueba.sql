CREATE TABLE PUBLIC.reservation(
reservation_id INTEGER PRIMARY KEY,
trip_id INTEGER FOREIGN KEY,
client_id INTEGER FOREIGN KEY,
created_at TIMESTAMPTZ,
seats INTEGER,
total_price INTEGER
);
--
CREATE TABLE PUBLIC.driver(
driver_id INTEGER PRIMARY KEY,
created_at TIMESTAMPTZ,
first_name VARCHAR(50),
last_name VARCHAR(50),
bithdate DATE,
gender VARCHAR(6)
);
--
COPY PUBLIC.driver FROM 'C:\Users\andyi\OneDrive\Documentos\Prueba\driver_table.csv' DELIMITER ',' CSV HEADER;
--
SELECT * FROM driver
--
CREATE TABLE PUBLIC.trip(
trip_id INTEGER PRIMARY KEY,
driver_id INTEGER,
on_sale_at TIMESTAMPTZ,
departure_at TIMESTAMPTZ,
arrival_at TIMESTAMPTZ,
vehicle_capacity INTEGER,
seat_price FLOAT,  
route_name TEXT,
line_name TEXT,
route_type TEXT,
CONSTRAINT fk_driver FOREIGN KEY (driver_id) REFERENCES driver (driver_id)
);
--
COPY PUBLIC.trip FROM 'C:\Users\andyi\OneDrive\Documentos\Prueba\trip_table.csv' DELIMITER ',' CSV HEADER;
--
CREATE TABLE PUBLIC.reservation(
reservation_id INTEGER PRIMARY KEY,
trip_id INTEGER,
client_id INTEGER,
created_at TIMESTAMPTZ,
seats INTEGER,
total_price INTEGER,
CONSTRAINT fk_trip FOREIGN KEY (trip_id) REFERENCES trip (trip_id),
CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES client (client_id)
);
--
COPY PUBLIC.reservation FROM 'C:\Users\andyi\OneDrive\Documentos\Prueba\reservation_table.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM trip
--
SELECT trip.trip_id, trip.departure_at, trip.arrival_at, trip.route_name, trip.vehicle_capacity, reservation.total_price, (SELECT (trip.vehicle_capacity-reservation.seats) as soldseats), (SELECT (((((trip.vehicle_capacity-reservation.seats))*100)/trip.vehicle_capacity)-100)*-1 as occupancy) FROM trip JOIN reservation ON trip.trip_id = reservation.trip_id WHERE trip.departure_at BETWEEN '01-11-2017' AND '30-11-2017'
--
SELECT * FROM reservation
