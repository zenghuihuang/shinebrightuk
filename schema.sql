CREATE DATABASE test_shine_bright;
USE test_shine_bright;
DROP TABLE IF EXISTS Activities_Offered;
DROP TABLE IF EXISTS Member_Activities_Interested;
DROP TABLE IF EXISTS Attendances;  
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS HowHeardAboutUs;
CREATE TABLE HowHeardAboutUs (
    source_id INT AUTO_INCREMENT PRIMARY KEY,
    source_name VARCHAR(100) NOT NULL UNIQUE  -- e.g., Friend, Social Media, Flyer, Social Prescriber, Other
);

-- =====================================
-- Insert records into HowHeardAboutUs
-- =====================================

INSERT INTO HowHeardAboutUs (source_name) VALUES
('From a friend'),
('Social media'),
('Social prescriber'),
('Flyer');

DROP TABLE IF EXISTS Activities_Scheduled;
CREATE TABLE Activities_Scheduled (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type ENUM('Workshop','Event','Course') NOT NULL,
    duration_weeks INT NULL,
    start_date DATE NULL,
    end_date DATE NULL
);

-- ️Activities offered by Shine Bright
DROP TABLE IF EXISTS Activities_Offered; 
CREATE TABLE Activities_Offered (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
-- Example data
INSERT INTO Activities_Offered (name) VALUES
('Chair Zumba'),
('Zumba'),
('Art & Craft for Wellbeing'),
('Singing for Wellbeing'),
('Drumming for Wellbeing'),
('Yoga for Wellbeing'),
('Yogic Sleep Meditation'),
('Healthy Cooking on a Budget'),
('Mindful Knitting'),
('Tea and Talk'),
('Happy Healthy Habits');

-- Link members to activities they are interested in
DROP TABLE IF EXISTS Member_Activities_Interested;
CREATE TABLE Member_Activities_Interested (
    member_id INT NOT NULL,
    activity_id INT NOT NULL,
    PRIMARY KEY (member_id, activity_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (activity_id) REFERENCES Activities_Offered(activity_id)
);

-- Members interested in Zumba
SELECT m.first_name, m.surname
FROM Members m
JOIN Member_Activities_Interested mi ON m.member_id = mi.member_id
JOIN Activities_Offered a ON mi.activity_id = a.activity_id
WHERE a.name = 'Zumba';

-- Track actual attendances
CREATE TABLE Attendances (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    activity_id INT NOT NULL,
    attended_on DATE NOT NULL,      -- date member attended
    notes TEXT,                     -- optional notes
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (activity_id) REFERENCES Activities_Offered(activity_id)
);


-- Members table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(50),
    postcode VARCHAR(20),
    preferred_contact ENUM('Email','Phone/Text'),
    gender ENUM('Female','Male','Prefer not to say','Other'),
    age_range ENUM('18-24','25-34','35-44','45-54','55-64','Over 65','Prefer not to say'),
    ethnic_group VARCHAR(255),
    
    -- Registrant info (who submitted the form)
    on_behalf BOOLEAN DEFAULT FALSE,
    relationship VARCHAR(100),  -- NULL if self
    registrant_name VARCHAR(150),
    registrant_email VARCHAR(255),
    registrant_phone VARCHAR(50),
    
    -- Optional volunteer info
    interested_in_volunteering ENUM('Yes','No','Other'),
    want_leaflet BOOLEAN,                     -- TRUE = wants leaflet
    
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key to HowHeardAboutUs
    source_id INT,
    CONSTRAINT fk_source FOREIGN KEY (source_id) REFERENCES HowHeardAboutUs(source_id)
);

SHOW TABLES;
DESCRIBE Members;

/* 
This is a multiline comment
for Shine Bright UK Members table
ENUM('White','English/Welsh/Scottish/Northern Irish/British','Irish','Gypsy or Irish Traveller','Any other White background','Mixed/Multiple ethnic groups','White and Black Caribbean','White and Black African','White and Asian','Any other Mixed','Asian/Asian British','Indian','Pakistan','Bangladeshi','Chinese','Any other Asian background','Black/African/Caribbean/Black British','African','Caribbean','Any other Black/African/Carribean background','Other')
*/


INSERT INTO Members VALUES
(1,'Amira','Saif Al Hammadi','amirasaif25@gmail.com','07501 245506','KT6 4NG','Phone/Text','Female','25-34','Saudi Arabian','2025-06-10 21:16:50'),
(2,'Angela','Hilton','angela_hilton48@outlook.com','07801 082514','KT4 7RH','Email','Female','Over 65','English/Welsh/Scottish/Northern Irish/British','2025-09-18 15:15:32'),
(3,'Anne','Ramlakhan','anneramlakhan@cloud.com','07900 888032','KT6 7SR','Phone/Text','Female','Over 65','Caribbean',
'2025-09-18 18:41:04');

