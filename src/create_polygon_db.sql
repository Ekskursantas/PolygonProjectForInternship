-- CreatePolygonDatabase - final version
use Polygon;


Drop table if exists ServiceRequest;
Drop table if exists Services;
Drop table if exists CheckupReport;
Drop table if exists Room;
Drop table if exists Building;
Drop table if exists City;
Drop table if exists Customer;
Drop table if exists Employee;


create table Employee(
emp_id int primary key auto_increment,
fname varchar(30) NOT NULL,
lname varchar(30) NOT NULL,
username varchar(30) NOT NULL,
pwd varchar(30) NOT NULL,
email varchar(30),
phone_no varchar(15)
);

create table Customer(
customer_id int(8) NOT NULL AUTO_INCREMENT PRIMARY KEY,
company_name varchar(30),
fname varchar(30) NOT NULL,
lname varchar(30) NOT NULL,
username varchar(30) NOT NULL,
pwd varchar(30) NOT NULL,
email varchar(30),
phone_no varchar(15)
);

create table City(
zip int(10) primary key,
city varchar(50) NOT NULL
);

create table Building (
building_id int(8) NOT NULL AUTO_INCREMENT PRIMARY KEY,
name varchar(30),
street varchar(50) NOT NULL,
zip int(10) NOT NULL,
parcel_no int,
size int(5) NOT NULL,
year int (4),
buildingUse varchar(50),
condition_level int,
floorplanURL varchar(50),
customer_id int NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

create table Room(
room_id int primary key auto_increment,
building_id int NOT NULL,
size int,
FOREIGN KEY (building_id) REFERENCES Building(building_id)
);

create table CheckupReport(
creport_id int auto_increment primary key,
building_id int NOT NULL,
checkDate DATE,
condition_level int,
roof varchar(200),
walls_outside varchar(200),
damaged enum('yes', 'no'),
damage_when varchar(50),
damage_where varchar(100),
damage_what varchar(200),
damage_repaired varchar(200),
walls varchar(200),
ceiling varchar(200),
floor varchar(200),
windows_doors varchar(200),
moisture_scanning enum('yes', 'no'),
moisture_measure varchar(200),
reportStatus enum('pending','active','done') NOT NULL,
comments varchar(255),
room_id int,
employee_id int,
FOREIGN KEY (building_id) REFERENCES Building(building_id),
FOREIGN KEY (employee_id) REFERENCES Employee(emp_id),
FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

create table Services(
service_id int primary key,
service_name varchar(40)
);

create table ServiceRequest(
srequest_id int primary key AUTO_INCREMENT,
building_id int NOT NULL,
employee_id int,
requestDate DATE,
checkDate DATE,
service_id int,
description varchar(255),
reportStatus enum('pending','active','done') NOT NULL,
FOREIGN KEY (building_id) REFERENCES Building(building_id),
FOREIGN KEY (employee_id) REFERENCES Employee(emp_id)
);
