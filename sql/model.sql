-- таблица людей, участвующих в обследовании
CREATE TABLE person(
	id					int NOT NULL,			    -- id
	name				varchar(15) NOT NULL,	    -- имя
	surname				varchar(20) NOT NULL,       -- фамилия
	company_id			varchar(50) NULL,           -- место аботы
	position_id			varchar(100) NULL,          -- должность (старший, младший)
	profession  		varchar(50) NULL,           -- профессия
	                                                
	PRIMARY KEY (id)                                
)                                                   
GO                                                  
                                                    
-- таблица пациентов                                
CREATE TABLE patient(                               
	id					int NOT NULL,               -- id
	person_id			int NOT NULL,               -- id участника обследования
	adress				varchar(100) NULL,          -- адрес
	blood_type  		varchar(2) NULL,            -- группа крови
	cf_normal   		int NOT NULL,               -- КЧСМ (нормальный)
	
	PRIMARY KEY (id)
)
GO

-- таблица врачей
CREATE TABLE doctor(
	id					int NOT NULL,               -- id
	person_id			int NOT NULL,               -- id врача
	
	PRIMARY KEY (id)
)
GO

-- таблица компаний
CREATE TABLE company(
	id 					int NOT NULL, 				-- id		
	name				varchar(50) NOT NULL,		-- название компании
	activity    		varchar(100) NULL,			-- область деятельности
	risk				varchar(20) NULL,			-- степень важности медицинских показаний
	
	PRIMARY KEY (id)
)
GO

-- таблица должностей
CREATE TABLE position(
	id					int NOT NULL,				-- id
	name				varchar(100) NOT NULL,      -- наименование должности
	lvl					varchar(20) NULL,		    -- должность (старший, младший)
		
	PRIMARY KEY (id)
)
GO

-- таблица лекарств
CREATE TABLE meds(
	id					int NOT NULL,				-- id
	med_type			varchar(50) NOT NULL,		-- тип лекарственного средства
	name				varchar(150) NOT NULL,		-- название препарата
	
	PRIMARY KEY(id)
)

-- таблица принимаемых лекарств
CREATE TABLE cure(
	id					int NOT NULL,			    -- id
	patient_id			int NOT NULL,			    -- id пациента
	doc_id				int NOT NULL,				-- id врача
	meds_id				int NOT NULL,			    -- id лекарства
	date_start			date NOT NULL,			    -- дата начала приема
	date_end			date NOT NULL,			    -- дата конца приема
	                                                
	PRIMARY KEY(id)                                 
)                                                   
                                                    
-- таблица результатов измерения КЧСМ               
CREATE TABLE measure(                               
	id 					int NOT NULL,			    -- id
	patient_id 			int NOT NULL,			    -- id пациента
	doc_id 				int NOT NULL,			    -- id доктора
	crit_f 				int NOT NULL,			    -- КЧСМ
	                                                
	PRIMARY KEY(id)                                 
)                                                   
                                                    
-- таблица посещений                                
CREATE TABLE diagnostic(                            
	id					int NOT NULL,               -- id
	patient_id			int NOT NULL,               -- id пациента
	doctor_id			int NOT NULL,               -- id врача
	analysis			varchar(100) NULL,          -- результаты анализов
	proc_done			varchar(100) NULL,          -- пройденые процедуры
	diagnosis			varchar(2500) NOT NULL,     -- диагнозы
	d_comment			varchar(5000) NULL,			-- комментарии к диагнозу
	lat_visit			date NOT NULL,              -- последнее посещение
	suspend_till		date NULL,                  -- время больничного (возможная нетрудоспообность до такого-то числа)
	
	PRIMARY KEY (id)
)
GO


-- внешние ключи --

ALTER TABLE diagnostic
    ADD FOREIGN KEY (patient_id)
		REFERENCES patient
GO

ALTER TABLE diagnostic
    ADD FOREIGN KEY (doc_id)
		REFERENCES doctor
GO

ALTER TABLE doctor
    ADD FOREIGN KEY (person_id)
		REFERENCES person
GO

ALTER TABLE patient
    ADD FOREIGN KEY (person_id)
		REFERENCES person
GO

ALTER TABLE person
    ADD FOREIGN KEY (company_id)
		REFERENCES company
GO

ALTER TABLE person
    ADD FOREIGN KEY (position_id)
		REFERENCES position
GO

ALTER TABLE cure
    ADD FOREIGN KEY (meds_id)
		REFERENCES meds
GO

ALTER TABLE cure
    ADD FOREIGN KEY (doc_id)
		REFERENCES doctor
GO

ALTER TABLE cure
    ADD FOREIGN KEY (patient_id)
		REFERENCES patient
GO

ALTER TABLE measure
    ADD FOREIGN KEY (patient_id)
		REFERENCES patient
GO

ALTER TABLE measure
    ADD FOREIGN KEY (doc_id)
		REFERENCES doctor
GO