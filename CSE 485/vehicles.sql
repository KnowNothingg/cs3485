CREATE SCHEMA vehicles;

create table vehicles.Manufacturer (
    manufacturerID int.
    mf_name text,
    primary key(manufacturerID)
);

create table vehicles.Vehicle (
    vehicleID int,
    manufacturerID int,
    primary key(vehicleID),
    foreign key(manufacturerID) references Manufacturer
);

create table vehicles.TransportationVehicle (
    loadCapacity int
    
) inherits(Vehicle);

create table vehicles.PassengerVehicle (
    numPassengers int
) inherits(Vehicle);

create table vehicles.Truck (
    numContainers int
) inherits(TransportationVehicle,PassengerVehicle);

create table MotorPool (
    motorPoolID int,
    primary key(motorPoolID)
);

create table Car (
    numDoors int,
    belongsTo int,
    foreign key (belongsTo) references MotorPool
) inherits(PassengerVehicle);