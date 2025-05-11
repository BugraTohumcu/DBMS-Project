CREATE TABLE Country(
    country_id INT PRIMARY KEY,
    country_name VARCHAR2(35)
);

CREATE TABLE Cost(
    cost_id INT PRIMARY KEY,    
    cost_of NUMBER(10),
    maintenance NUMBER(10),
    operational NUMBER(10)
);

CREATE TABLE Primary_Equipment (
    weapon_id INT PRIMARY KEY,
    weapon_type VARCHAR2(100),
    equipment_name VARCHAR2(100),
    release_date NUMBER(10)
);

CREATE TABLE Secondary_Equipment(
    equipment_id NUMBER(10) PRIMARY KEY,
    equipment_type NUMBER(10),
    equipment_name VARCHAR2(100),
    release_id NUMBER(10)
);

CREATE TABLE Man_Equipment_Relation (
    mer_id INT PRIMARY KEY,
    equipment_id INT,
    FOREIGN KEY (equipment_id) REFERENCES Secondary_Equipment(equipment_id)
);

CREATE TABLE Infantry (
    infantry_id INT PRIMARY KEY,
    mer_id INT,
    rank_soldier NUMBER(10),
    weapon_id INT,
    FOREIGN KEY (mer_id) REFERENCES Man_Equipment_Relation(mer_id),
    FOREIGN KEY (weapon_id) REFERENCES Primary_Equipment(weapon_id)
);

CREATE TABLE Inf_Suq_Rel (
   isr_id INT PRIMARY KEY,
   infantry_id INT,
   FOREIGN KEY (infantry_id) REFERENCES Infantry(infantry_id)
);

CREATE TABLE Vehicle(
    vehicle_id INT PRIMARY KEY,
    vehicle_name VARCHAR2(100),
    vehicle_type VARCHAR2(100),
    number_of_crew NUMBER(10),
    release_date NUMBER(10),
    cost_id INT REFERENCES Cost(cost_id),
    country_id INT REFERENCES Country(country_id)
);

CREATE TABLE Helicopter (
    vehicle_id NUMBER(10),
    Ground_Attack NUMBER(10),
    helicopter_speed NUMBER(10),
    Stealth_Coefficient NUMBER(10),
    CONSTRAINT heli_pk PRIMARY KEY (vehicle_id),
    CONSTRAINT heli_fk FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

CREATE TABLE Ship (
    vehicle_id INT NOT NULL PRIMARY KEY,
    ads_power NUMBER(10),
    ballistic_power NUMBER(10) NOT NULL,
    ship_speed NUMBER(10),
    attack_range NUMBER(10),
    CONSTRAINT ship_fk FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

CREATE TABLE Tank (
    vehicle_id NUMBER(10),
    Ballistic_Power NUMBER(10),
    Durability_Coefficient NUMBER(10),
    Piercing_Power NUMBER(10),
    CONSTRAINT pk_tank PRIMARY KEY (vehicle_id),
    CONSTRAINT fk_tank_vehicle FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

CREATE TABLE Vehicle_Army_Relation (
    var_id INT NOT NULL PRIMARY KEY,
    vehicle_id INT NOT NULL,
    CONSTRAINT var_fk FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

CREATE TABLE Squad (
    squad_id INT PRIMARY KEY,
    squad_type VARCHAR2(100),
    squad_name VARCHAR2(100),
    release_date NUMBER(10),
    isr_id INT REFERENCES Inf_Suq_Rel(isr_id),
    squad_vehicle VARCHAR2(100),
    communication_range NUMBER(10),
    number_of_crew NUMBER(10),
    power_of_squad NUMBER(10)
);

CREATE TABLE Squad_Army_Relation(
    sar_id NUMBER(10) PRIMARY KEY,
    squad_id NUMBER(10) REFERENCES Squad(Squad_id)
);

CREATE TABLE ARMY (
    army_id NUMBER(10) PRIMARY KEY,
    army_name VARCHAR2(100),
    sar_id NUMBER(10),
    var_id NUMBER(10),
    linked_unit VARCHAR2(100),
    country_id NUMBER(10),
    cost_id NUMBER(10),
    release_date NUMBER(10),
    number_of_crew NUMBER(10),
    created_by_user NUMBER(10),
    CONSTRAINT fk_army_sar FOREIGN KEY (sar_id) REFERENCES Squad_Army_Relation(sar_id),
    CONSTRAINT fk_army_var FOREIGN KEY (var_id) REFERENCES Vehicle_Army_Relation(var_id),
    CONSTRAINT fk_army_country FOREIGN KEY (country_id) REFERENCES Country(country_id),
    CONSTRAINT fk_army_cost FOREIGN KEY (cost_id) REFERENCES Cost(cost_id),
);

