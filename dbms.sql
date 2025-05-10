create table Country(
    country_id int primary key,
    country_name varchar2(35)
);

create table Release_date(
    release_id int primary key,
    release_date date
);

create table Cost(
    cost_id int primary key,
    cost_of NUMBER(10),
    maintanance NUMBER(10),
    operational NUMBER(10)
);

CREATE TABLE Primary_Equipment (
    weapon_id INT PRIMARY KEY,
    weapon_type VARCHAR2(100),
    equipment_name VARCHAR2(100),
    release_id int,
    FOREIGN KEY (release_id) REFERENCES release_date(release_id)
);

CREATE table Secondary_Equipment(
    equipment_id NUMBER(10) primary key,
    equipment_type NUMBER(10),
    equipment_name varchar2(100),
    release_id NUMBER(10)
);
CREATE TABLE Man_Equipment_Relation (
    mer_id INT PRIMARY KEY,
    equipment_id INT,
    FOREIGN KEY (equipment_id) REFERENCES SECONDARY_EQUIPMENT(equipment_id)
);

CREATE TABLE Infantry (
    infantry_id INT PRIMARY KEY,
    mer_id INT,
    rank_soldier NUMBER(10),
    weapon_id INT,
    FOREIGN KEY (mer_id) REFERENCES MAN_EQUIPMENT_RELATION(mer_id),
    FOREIGN KEY (weapon_id) REFERENCES PRIMARY_EQUIPMENT(weapon_id)
);


CREATE TABLE Inf_Suq_Rel (
   isr_id INT primary key,
   infantry_id INT,
   FOREIGN KEY (infantry_id) REFERENCES INFANTRY(infantry_id)
);

create table Vehicle(
    vehicle_id int primary key,
    vehicle_name varchar2(100),
    vehicle_type varchar2(100),
    number_of_crew NUMBER(10),
    release_id int REFERENCES release_date(release_id),
    cost_id int REFERENCES cost(cost_id),
    country_id int REFERENCES country(country_id)
);

CREATE TABLE Helicopter (
    vehicle_id NUMBER(10),
    Ground_Attack NUMBER(10),
    helicopter_speed NUMBER(10),
    Stealth_Coefficent NUMBER(10),
    CONSTRAINT heli_pk PRIMARY KEY (vehicle_id),
    CONSTRAINT heli_fk FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

create table Ship (
    vehicle_id int not null primary key,
    ads_power NUMBER(10),
    balistic_power NUMBER(10) not null,
    ship_speed NUMBER(10),
    attack_range NUMBER(10),
    CONSTRAINT ship_fk FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id)
);

CREATE TABLE Tank (
    vehicle_id NUMBER(10),
    Balistic_Power NUMBER(10),
    Durabilty_Coefficent NUMBER(10),
    Piercing_Power NUMBER(10),
    CONSTRAINT pk_tank PRIMARY KEY (vehicle_id),
    CONSTRAINT fk_tank_vehicle FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

create table Vehicle_Army_Relation (
    var_id int not null primary key,
    vehicle_id int not null,
    CONSTRAINT var_fk REFERENCES vehicle(vehicle_id)
);

CREATE TABLE Squad (
    squad_id int PRIMARY KEY,
    squad_type VARCHAR2(100),
    squad_name VARCHAR2(100),
    release_date NUMBER(10),
    isr_id int REFERENCES Inf_Suq_Rel(isr_id),
    squad_vehicle VARCHAR2(100),
    communication_range NUMBER(10),
    number_of_crew NUMBER(10),
    power_of_squad NUMBER(10)
);

CREATE TABLE  Squad_Army_Relation(
    Sar_id NUMBER(10) PRIMARY KEY,
    Squad_id NUMBER(10) REFERENCES SQUAD(Squad_id)
);

CREATE TABLE ARMY (
    Army_id NUMBER(10) PRIMARY KEY,
    Army_Name VARCHAR2(100),
    SAR_id NUMBER(10),
    var_id NUMBER(10),
    Linked_Unit VARCHAR2(100),
    Country_id NUMBER(10),
    Cost_id NUMBER(10),
    release_id NUMBER(10),
    number_Of_Crew NUMBER(10),
    Created_By_User NUMBER(10),

    CONSTRAINT fk_army_sar FOREIGN KEY (SAR_id) REFERENCES Squad_Army_Relation(SAR_id),
    CONSTRAINT fk_army_var FOREIGN KEY (var_id) REFERENCES Vehicle_Army_Relation(var_id),
    CONSTRAINT fk_army_country FOREIGN KEY (Country_id) REFERENCES Country(Country_id),
    CONSTRAINT fk_army_cost FOREIGN KEY (Cost_id) REFERENCES Cost(Cost_id)
    CONSTRAINT fk_army_date FOREIGN KEY (release_id) REFERENCES Release_date(release_id)

);