create table CarCustomer 
    (CustomerID NUMBER(10), 
    Fname VARCHAR2(20),
    Lname VARCHAR2(20),
    Phone# NUMBER(10) NOT NULL,
    CONSTRAINT customers_pk PRIMARY KEY (CustomerID),
    CONSTRAINT phonenum_uk UNIQUE (Phone#));

create table Vehicle
	(VIN VARCHAR2(20),
	CustomerID NUMBER(10),
	Make varchar2(20),
	Model varchar2(20),
	Year number(4),
	constraint vehicles_pk primary key (VIN),
	constraint customer_fk foreign key (CustomerID) references CarCustomer (CustomerID));

create table CarOrder
    (OrderID number(10),
    CustomerID number(10),
    VIN varchar(17),
    OrderDate date default SYSDATE,
    constraint carorder_pk primary key (OrderID),
    constraint customerid_fk foreign key (CustomerID) references CarCustomer (CustomerID),
    constraint vin_fk foreign key (VIN) references Vehicle (VIN)); 

create table Parts
    (PartID number(10),
    PartName varchar2(20),
    Quantity number(2),
    Price number(7,2),
    constraint parts_pk primary key (PartID),
    constraint quantity_ck check (Quantity > 0));
    
create table Services
    (ServiceID number(10),
    Price number(7,2),
    ServiceName varchar2(20),
    constraint services_pk primary key (ServiceID));
    
create table ServicesPerformed
    (OrderID number(10),
    ServiceID number(10),
    DatePerformed DATE,
    constraint servicesperformed_pk primary key (OrderID, ServiceID),
    constraint orderid_fk foreign key (OrderID) references CarOrder(OrderID),
    constraint serviceid_fk foreign key (ServiceID) references Services(ServiceID));
    
create sequence seq_partid
    start with 1
    increment by 1
    minvalue 1
    maxvalue 9999999999
    cycle
    nocache;

create sequence seq_customerid
    start with 1
    increment by 1
    minvalue 1
    maxvalue 9999999999
    cycle
    nocache;
    
commit;

insert into CarCustomer (CustomerID, Fname, Lname, Phone#) values (seq_customerid.NEXTVAL, 'John', 'Doe', 1234567890);
insert into CarCustomer (CustomerID, Fname, Lname, Phone#) values (seq_customerid.NEXTVAL, 'Jane', 'Smith', 2345678901);
insert into CarCustomer (CustomerID, Fname, Lname, Phone#) values (seq_customerid.NEXTVAL, 'Alice', 'Johnson', 3456789012);
insert into CarCustomer (CustomerID, Fname, Lname, Phone#) values (seq_customerid.NEXTVAL, 'Bob', 'Brown', 4567890123);
insert into CarCustomer (CustomerID, Fname, Lname, Phone#) values (seq_customerid.NEXTVAL, 'Carol', 'Davis', 5678901234);

insert into Vehicle (VIN, CustomerID, Make, Model, Year) values ('1M8GDM9AXKP042788', 1, 'Toyota', 'Corolla', 2020);
insert into Vehicle (VIN, CustomerID, Make, Model, Year) values ('1HGCM82633A004352', 2, 'Honda', 'Civic', 2019);
insert into Vehicle (VIN, CustomerID, Make, Model, Year) values ('2FMDK3GC4ABB56789', 3, 'Ford', 'Escape', 2018);
insert into Vehicle (VIN, CustomerID, Make, Model, Year) values ('1N4AL3AP0FC123456', 4, 'Nissan', 'Altima', 2021);
insert into Vehicle (VIN, CustomerID, Make, Model, Year) values ('3CZRM3H56FG789012', 5, 'Honda', 'CR-V', 2022);

insert into CarOrder (OrderID, CustomerID, VIN, OrderDate) values (1, 1, '1M8GDM9AXKP042788', to_date('2024-01-26', 'YYYY-MM-DD'));
insert into CarOrder (OrderID, CustomerID, VIN, OrderDate) values (2, 2, '1HGCM82633A004352', to_date('2024-02-20', 'YYYY-MM-DD'));
insert into CarOrder (OrderID, CustomerID, VIN, OrderDate) values (3, 3, '2FMDK3GC4ABB56789', to_date('2024-03-21', 'YYYY-MM-DD'));
insert into CarOrder (OrderID, CustomerID, VIN, OrderDate) values (4, 4, '1N4AL3AP0FC123456', to_date('2024-04-05', 'YYYY-MM-DD'));
insert into CarOrder (OrderID, CustomerID, VIN, OrderDate) values (5, 5, '3CZRM3H56FG789012', to_date('2024-05-26', 'YYYY-MM-DD'));

insert into Parts (PartID, PartName, Quantity, Price) values (seq_partid.NEXTVAL, 'Oil Filter', 10, 7.99);
insert into Parts (PartID, PartName, Quantity, Price) values (seq_partid.NEXTVAL, 'Air Filter', 15, 15.99);
insert into Parts (PartID, PartName, Quantity, Price) values (seq_partid.NEXTVAL, 'Brake Pads', 20, 35.99);
insert into Parts (PartID, PartName, Quantity, Price) values (seq_partid.NEXTVAL, 'Spark Plug', 50, 3.99);
insert into Parts (PartID, PartName, Quantity, Price) values (seq_partid.NEXTVAL, 'Battery', 5, 89.99);

insert into Services (ServiceID, Price, ServiceName) values (1, 49.99, 'Oil Change');
insert into Services (ServiceID, Price, ServiceName) values (2, 79.99, 'Tire Rotation');
insert into Services (ServiceID, Price, ServiceName) values (3, 199.99, 'Transmission Repair');
insert into Services (ServiceID, Price, ServiceName) values (4, 299.99, 'Engine Overhaul');
insert into Services (ServiceID, Price, ServiceName) values (5, 99.99, 'AC Repair');

insert into ServicesPerformed (OrderID, ServiceID, DatePerformed) values (1, 1, to_date('2024-01-30', 'YYYY-MM-DD'));
insert into ServicesPerformed (OrderID, ServiceID, DatePerformed) values (2, 2, to_date('2024-02-22', 'YYYY-MM-DD'));
insert into ServicesPerformed (OrderID, ServiceID, DatePerformed) values (3, 3, to_date('2024-03-26', 'YYYY-MM-DD'));
insert into ServicesPerformed (OrderID, ServiceID, DatePerformed) values (4, 4, to_date('2024-04-11', 'YYYY-MM-DD'));
insert into ServicesPerformed (OrderID, ServiceID, DatePerformed) values (5, 5, to_date('2024-05-30', 'YYYY-MM-DD'));

commit;