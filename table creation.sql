create database AssetManagement;

use AssetManagement;
go

create table employees (
    employee_id int primary key,
    name varchar(100),
    department varchar(50),
    email varchar(100) unique,
    password varchar(255)
);
INSERT INTO employees (employee_id, name, department, email, password)
VALUES
(101, 'Sneha', 'HR', 'sneha@gmail.com', 'Sneha@1234'),
(102, 'Dev', 'HR', 'dev@gmail.com', 'Dev@1234'),
(103, 'Diya', 'Q&A', 'diya@gmail.com', 'Diya@1234'),
(104, 'Krishvi', 'Frontend', 'krishvi@gmail.com', 'Krishvi@1234'),
(105, 'Dwithi', 'Tech Analyst', 'dwithi@gmail.com', 'Dwithi@1234'),
(106, 'Akhil', 'Backend', 'akhil@gmail.com', 'Akhil@1234');

create table assets (
    asset_id int primary key,
    name varchar(100),
    type varchar(50),
    serial_number varchar(50) unique,
    purchase_date date,
    location varchar(100),
    status varchar(50),
    owner_id int,
    foreign key (owner_id) references employees(employee_id) on delete set null
);

create table maintenance_records (
    maintenance_id int primary key,
    asset_id int,
    maintenance_date date,
    description varchar(255),
    cost decimal(10,2),
    foreign key (asset_id) references assets(asset_id) on delete cascade
);

create table asset_allocations (
    allocation_id int primary key,
    asset_id int,
    employee_id int,
    allocation_date date,
    return_date date,
    foreign key (asset_id) references assets(asset_id) on delete cascade,
    foreign key (employee_id) references employees(employee_id) on delete cascade
);

create table reservations (
    reservation_id int primary key,
    asset_id int,
    employee_id int,
    reservation_date date,
    start_date date,
    end_date date,
    status varchar(50),
    foreign key (asset_id) references assets(asset_id) on delete cascade,
    foreign key (employee_id) references employees(employee_id) on delete cascade
);

