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
    cost_of NUMBER,
    maintanance NUMBER,
    operational NUMBER
);

CREATE TABLE Primary_Equipment (
    weapon_id INT PRIMARY KEY,
    weapon_type VARCHAR2(100),
    equipment_name VARCHAR2(100),
    release_id int,
    FOREIGN KEY (release_id) REFERENCES release_date(release_id)
);

CREATE table Secondary_Equipment(
    equipment_id NUMBER primary key,
    equipment_type NUMBER,
    equipment_name varchar2(100),
    release_id NUMBER
);
CREATE TABLE Man_Equipment_Relation (
    mer_id INT PRIMARY KEY,
    equipment_id INT,
    FOREIGN KEY (equipment_id) REFERENCES SECONDARY_EQUIPMENT(equipment_id)
)

CREATE TABLE Infantry (
    infantry_id INT PRIMARY KEY,
    mer_id INT,
    rank_soldier NUMBER,
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
    NUMBER_of_crew NUMBER,
    release_id int REFERENCES release_date(release_id),
    cost_id int REFERENCES cost(cost_id),
    country_id int REFERENCES country(country_id)
);

CREATE TABLE Helicopter (
    vehicle_id NUMBER,
    Ground_Attack NUMBER,
    helicopter_speed NUMBER,
    Stealth_Coefficent NUMBER,
    CONSTRAINT heli_pk PRIMARY KEY (vehicle_id),
    CONSTRAINT heli_fk FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

create table Ship (
    vehicle_id int not null primary key,
    ads_power NUMBER,
    balistic_power NUMBER not null,
    ship_speed NUMBER,
    attack_range NUMBER,
    CONSTRAINT ship_fk FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id)
);

CREATE TABLE Tank (
    vehicle_id NUMBER,
    Balistic_Power NUMBER,
    Durabilty_Coefficent NUMBER,
    Piercing_Power NUMBER,
    CONSTRAINT pk_tank PRIMARY KEY (vehicle_id),
    CONSTRAINT fk_tank_vehicle FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

create table Vehicle_Army_Relation (
    var_id int not null primary key,
    vehicle_id int not null
    CONSTRAINT var_fk REFERENCES vehicle(vehicle_id)
);

CREATE TABLE Squad (
    squad_id NUMBER PRIMARY KEY,
    squad_type VARCHAR2(100),
    squad_name VARCHAR2(100),
    release_date NUMBER,
    isr_id NUMBER REFERENCES Inf_Suq_Rel(isr_id),
    squad_vehicle VARCHAR2(100),
    communication_range NUMBER,
    NUMBER_of_crew NUMBER,
    power_of_squad NUMBER
);

CREATE TABLE  Squad_Army_Relation(
    Sar_id NUMBER PRIMARY KEY,
    Squad_id NUMBER REFERENCES SQUAD(Squad_id)
);

CREATE TABLE ARMY (
    Army_id NUMBER PRIMARY KEY,
    Army_Name VARCHAR2(100),
    SAR_id NUMBER,
    var_id NUMBER,
    Linked_Unit VARCHAR2(100),
    Country_id NUMBER,
    Cost_id NUMBER,
    release_id NUMBER,
    NUMBER_Of_Crew NUMBER,
    Created_By_User NUMBER,

    CONSTRAINT fk_army_sar FOREIGN KEY (SAR_id) REFERENCES Squad_Army_Relation(SAR_id),
    CONSTRAINT fk_army_var FOREIGN KEY (var_id) REFERENCES Vehicle_Army_Relation(var_id),
    CONSTRAINT fk_army_country FOREIGN KEY (Country_id) REFERENCES Country(Country_id),
    CONSTRAINT fk_army_cost FOREIGN KEY (Cost_id) REFERENCES Cost(Cost_id)
);