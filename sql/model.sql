CREATE TABLE patient(
	poi				int NOT NULL,
	name			varchar(15) NOT NULL,
	surname			varchar(20) NOT NULL,
	adress			varchar(100) NULL,
	company			varchar(50) NULL,
	position		varchar(100) NULL,
	blood_type  	varchar(2) NULL,
	cf_normal   	int NOT NULL,
	
	PRIMARY KEY (poi)
)
GO

CREATE TABLE doctor(
	id				int NOT NULL,
	name			varchar(15) NOT NULL,
	surname			varchar(20) NOT NULL,
	position		varchar(100) NOT NULL,
	profession  	varchar(50) NOT NULL,
	
	PRIMARY KEY (id)
)
GO


CREATE TABLE diagnostic(
	id				int NOT NULL,
	patient_id		int NOT NULL,
	doctor_id,		int NOT NULL,
	medicines		varchar(500) NOT NULL,
	cf_now			int NOT NULL,
	analysis		varchar(100) NULL, 
	proc_done		varchar(100) NULL,
	diagnosis		varchar(2500) NOT NULL,
	lat_visit		date NOT NULL,
	suspend_till	date NULL,
	
	PRIMARY KEY (id)
)
GO


ALTER TABLE diagnostic
    ADD FOREIGN KEY (patient_id)
		REFERENCES patient
GO

ALTER TABLE diagnostic
    ADD FOREIGN KEY (doc_id)
		REFERENCES doctor
GO