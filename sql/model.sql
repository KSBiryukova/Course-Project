-- таблица людей, участвующих в обследовании
CREATE TABLE person(
	id					int NOT NULL,			  -- id
	name				varchar(15) NOT NULL,	  -- имя
	surname				varchar(20) NOT NULL,     -- фамилия
	company				varchar(50) NULL,         -- место аботы
	position			varchar(100) NULL,        -- должность (старший, младший)
	profession  		varchar(50) NULL,         -- профессия
	
	PRIMARY KEY (id)
)
GO

-- таблица пациентов
CREATE TABLE patient(
	id					int NOT NULL,             -- id
	person_id			int NOT NULL,             -- id участника обследования
	adress				varchar(100) NULL,        -- адрес
	blood_type  		varchar(2) NULL,          -- группа крови
	cf_normal   		int NOT NULL,             -- КЧСМ (нормальный)
	
	PRIMARY KEY (id)
)
GO

-- таблица врачей
CREATE TABLE doctor(
	id					int NOT NULL,             -- id
	person_id			int NOT NULL,             -- id врача
	
	PRIMARY KEY (id)
)
GO

-- таблица компаний
CREATE TABLE company(
	name				varchar(50) NOT NULL,     -- название компании
	activity    		varchar(100) NULL,        -- область деятельности
	risk				varchar(20) NULL,         -- степень важности медицинских показаний
	
	PRIMARY KEY (name)
)
GO

-- таблица должностей
CREATE TABLE position(
	name				varchar(100) NOT NULL,    -- наименование должности
	lvl					varchar(20) NULL,		  -- должность (старший, младший)
		
	PRIMARY KEY (name)
)
GO

-- таблица посещений
CREATE TABLE diagnostic(
	id					int NOT NULL,             -- id
	patient_id			int NOT NULL,             -- id пациента
	doctor_id			int NOT NULL,             -- id врача
	medicines			varchar(500) NOT NULL,    -- принимаемые лекарства
	cf_now				int NOT NULL,             -- КЧСМ действующее
	analysis			varchar(100) NULL,        -- результаты анализов
	proc_done			varchar(100) NULL,        -- пройденые процедуры
	diagnosis			varchar(2500) NOT NULL,   -- диагнозы
	lat_visit			date NOT NULL,            -- последнее посещение
	suspend_till		date NULL,                -- время больничного (возможная нетрудоспообность)
	
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
    ADD FOREIGN KEY (company)
		REFERENCES company
GO

ALTER TABLE person
    ADD FOREIGN KEY (position)
		REFERENCES position
GO