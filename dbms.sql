CREATE TABLE Country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR2(35)
);

CREATE TABLE Cost (
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

CREATE TABLE Secondary_Equipment (
    equipment_id NUMBER(10) PRIMARY KEY,
    equipment_type NUMBER(10),
    equipment_name VARCHAR2(100),
    release_id NUMBER(10)
);


CREATE TABLE Infantry (
    infantry_id INT PRIMARY KEY,
    rank_soldier NUMBER(10),
    weapon_id INT,
    FOREIGN KEY (weapon_id) REFERENCES Primary_Equipment(weapon_id)
);


CREATE TABLE Man_Equipment_Relation (
    infantry_id INT,
    equipment_id INT,
    PRIMARY KEY (infantry_id, equipment_id),
    FOREIGN KEY (infantry_id) REFERENCES Infantry(infantry_id),
    FOREIGN KEY (equipment_id) REFERENCES Secondary_Equipment(equipment_id)
);


CREATE TABLE Squad (
    squad_id INT PRIMARY KEY,
    squad_type VARCHAR2(100),
    squad_name VARCHAR2(100),
    release_date NUMBER(10),
    squad_vehicle VARCHAR2(100),
    communication_range NUMBER(10),
    number_of_crew NUMBER(10),
    power_of_squad NUMBER(10)
);


CREATE TABLE inf_suq_rel (
    infantry_id INT,
    squad_id INT,
    PRIMARY KEY (infantry_id, squad_id),
    FOREIGN KEY (infantry_id) REFERENCES Infantry(infantry_id),
    FOREIGN KEY (squad_id) REFERENCES Squad(squad_id)
);


CREATE TABLE Vehicle (
    vehicle_id INT PRIMARY KEY,
    vehicle_name VARCHAR2(100),
    vehicle_type VARCHAR2(100),
    number_of_crew NUMBER(10),
    release_date NUMBER(10),
    cost_id INT,
    country_id INT,
    FOREIGN KEY (cost_id) REFERENCES Cost(cost_id),
    FOREIGN KEY (country_id) REFERENCES Country(country_id)
);


CREATE TABLE Plane (
    vehicle_id NUMBER(10) PRIMARY KEY,
    Ground_Attack NUMBER(10),
    Air_Attack NUMBER(10),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

CREATE TABLE Helicopter (
    vehicle_id NUMBER(10) PRIMARY KEY,
    Ground_Attack NUMBER(10),
    helicopter_speed NUMBER(10),
    Stealth_Coefficient NUMBER(10),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

CREATE TABLE Ship (
    vehicle_id INT PRIMARY KEY,
    ads_power NUMBER(10),
    ballistic_power NUMBER(10) NOT NULL,
    ship_speed NUMBER(10),
    attack_range NUMBER(10),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

CREATE TABLE Tank (
    vehicle_id NUMBER(10) PRIMARY KEY,
    Ballistic_Power NUMBER(10),
    Durability_Coefficient NUMBER(10),
    Piercing_Power NUMBER(10),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);


CREATE TABLE Army (
    army_id NUMBER(10) PRIMARY KEY,
    army_name VARCHAR2(100),
    linked_unit VARCHAR2(100),
    country_id NUMBER(10),
    cost_id NUMBER(10),
    release_date NUMBER(10),
    number_of_crew NUMBER(10),
    FOREIGN KEY (country_id) REFERENCES Country(country_id),
    FOREIGN KEY (cost_id) REFERENCES Cost(cost_id)
);


CREATE TABLE VEHICLE_ARMY_RELATION (
    army_id INT,
    vehicle_id INT,
    PRIMARY KEY (army_id, vehicle_id),
    FOREIGN KEY (army_id) REFERENCES Army(army_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

CREATE TABLE Squad_army_Relation (
    squad_id INT,
    army_id INT,
    PRIMARY KEY (squad_id, army_id),
    FOREIGN KEY (squad_id) REFERENCES Squad(squad_id),
    FOREIGN KEY (army_id) REFERENCES Army(army_id)
);
