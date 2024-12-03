CREATE DATABASE IF NOT EXISTS TrainStations;
USE TrainStations;

-- Drop tables if they already exist
DROP TABLE IF EXISTS Messages;
DROP TABLE IF EXISTS Stops;
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Tschedule;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Station;
DROP TABLE IF EXISTS Train;

-- Station Table
CREATE TABLE Station (
    sid INT PRIMARY KEY, 
    name VARCHAR(50), 
    city VARCHAR(50), 
    state VARCHAR(50)
) ENGINE = InnoDB;

-- Train Table
CREATE TABLE Train (
    tid INT PRIMARY KEY
) ENGINE = InnoDB;

-- Customer Table
CREATE TABLE Customer (
    username VARCHAR(50) PRIMARY KEY, 
    password VARCHAR(50), 
    email VARCHAR(50), 
    first_name VARCHAR(50), 
    last_name VARCHAR(50)
) ENGINE = InnoDB;

-- Employee Table
CREATE TABLE Employee (
    username VARCHAR(50) PRIMARY KEY, 
    password VARCHAR(50), 
    ssn VARCHAR(11), 
    first_name VARCHAR(50), 
    last_name VARCHAR(50), 
    role ENUM('manager', 'customer_rep')
) ENGINE = InnoDB;

-- Train Schedule Table
CREATE TABLE Tschedule (
    schedule_id INT PRIMARY KEY, 
    transit_line VARCHAR(50), 
    origin_id INT, 
    destination_id INT, 
    travel_time INT, -- in minutes
    base_fare DOUBLE, 
    origin_departure DATETIME, 
    destination_arrival DATETIME, 
    train_id INT, 
    FOREIGN KEY (origin_id) REFERENCES Station(sid),
    FOREIGN KEY (destination_id) REFERENCES Station(sid),
    FOREIGN KEY (train_id) REFERENCES Train(tid)
) ENGINE = InnoDB;

-- Stops Table
CREATE TABLE Stops (
    stop_id INT PRIMARY KEY, 
    station_id INT, 
    schedule_id INT, 
    stop_sequence_num INT, 
    arrival DATETIME, 
    departure DATETIME, 
    fare DOUBLE, 
    FOREIGN KEY (station_id) REFERENCES Station(sid), 
    FOREIGN KEY (schedule_id) REFERENCES Tschedule(schedule_id)
) ENGINE = InnoDB;

-- Reservation Table
CREATE TABLE Reservation (
    rid INT PRIMARY KEY, 
    passenger VARCHAR(50), 
    total_fare DOUBLE, 
    date_made DATETIME, 
    origin_id INT, 
    destination_id INT, 
    schedule_id INT, 
    canceled BOOLEAN DEFAULT FALSE, 
    oversees VARCHAR(50), 
    trip_type ENUM('oneway', 'roundtrip'), 
    FOREIGN KEY (schedule_id) REFERENCES Tschedule(schedule_id),
    FOREIGN KEY (passenger) REFERENCES Customer(username), 
    FOREIGN KEY (oversees) REFERENCES Employee(username),
    FOREIGN KEY (origin_id) REFERENCES Station(sid),
    FOREIGN KEY (destination_id) REFERENCES Station(sid)
) ENGINE = InnoDB;

-- Messages Table (for customer-service interactions)
CREATE TABLE Messages (
    message_id INT PRIMARY KEY,
    customer_username VARCHAR(50),
    employee_username VARCHAR(50),
    message_content TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_username) REFERENCES Customer(username),
    FOREIGN KEY (employee_username) REFERENCES Employee(username)
) ENGINE = InnoDB;


delete from Employee;

insert into Employee(username, password) values
('mcarpenter', 'group21!'),
    ('Ade', 'group21!'),
    ('Ras', 'group21!'),
    ('Pavan', 'group21!');