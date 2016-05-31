----------------------------person-----------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_person_Add')
DROP PROCEDURE dias_person_Add
GO
CREATE PROCEDURE dias_person_Add
    @Name varchar(15),
	@Surname varchar(20),
	@Company_id int,
	@PositionId int,
	@Profession varchar(50)
AS
BEGIN
    DECLARE @P_id int
	SET @P_id = ISNULL((SELECT MAX(id) FROM person),0) + 1
	
	INSERT INTO dbo.person(id, name, surname, company_id, position_id, profession)
		VALUES(@P_id, @Name, @Surname, @Company_id, @PositionId, @Profession)
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_person_Update')
DROP PROCEDURE dias_person_Update
GO
CREATE PROCEDURE dias_person_Update
	@Id int,
    @Name varchar(15),
	@Surname varchar(20),
	@Company_id int,
	@PositionId int,
	@Profession varchar(50)
AS
BEGIN
    UPDATE dbo.person 
		SET
			name = @Name,
			surname = @Surname,
			company_id = @Company_id,
			position_id = @PositionId,
			profession = @Profession
	WHERE id = @Id
END
GO


----------------------------patient-----------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_patient_Add')
DROP PROCEDURE dias_patient_Add
GO
CREATE PROCEDURE dias_patient_Add
    @Adress varchar(100),
	@Blood_type varchar(2),
	@Cf_normal int
AS
BEGIN
    DECLARE @P_id int
	SET @P_id = ISNULL((SELECT MAX(id) FROM person),0) + 1
	DECLARE @Id int
	SET @Id = ISNULL((SELECT MAX(id) FROM patient),0) + 1
	
	INSERT INTO dbo.patient(id, person_id, adress, blood_type, cf_normal)
		VALUES(@Id, @P_id, @Adress, @Blood_type, @cf_normal)
END
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_patient_Update')
DROP PROCEDURE dias_patient_Update
GO
CREATE PROCEDURE dias_patient_Update
	@Id int,
    @Adress varchar(100)
AS
BEGIN
    UPDATE dbo.patient 
		SET
			Adress = @Adress
	WHERE id = @Id
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_patient_Delete')
DROP PROCEDURE dias_patient_Delete
GO
CREATE PROCEDURE dias_patient_Delete
	@Id int
AS
BEGIN
	DECLARE @P_id int
	SET @P_id = ISNULL((SELECT person_id FROM patient WHERE id = @Id),0)
	
    DELETE FROM dbo.patient WHERE id = @Id
	
	DELETE FROM dbo.person WHERE id = @P_id
	
	DELETE FROM dbo.cure WHERE patient_id = @Id
	
	DELETE FROM dbo.measure WHERE patient_id = @Id
	
	DELETE FROM dbo.diagnostic WHERE patient_id = @Id
END
GO


----------------------------doctor-----------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_doctor_Add')
DROP PROCEDURE dias_doctor_Add
GO
CREATE PROCEDURE dias_doctor_Add

BEGIN
    DECLARE @P_id int
	SET @P_id = ISNULL((SELECT MAX(id) FROM person),0) + 1
	DECLARE @Id int
	SET @Id = ISNULL((SELECT MAX(id) FROM doctor),0) + 1
	
	INSERT INTO dbo.doctor(id, person_id)
		VALUES(@Id, @P_id)
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_doctor_Delete')
DROP PROCEDURE dias_doctor_Delete
GO
CREATE PROCEDURE dias_doctor_Delete
	@Id int
AS
BEGIN
	DECLARE @P_id int
	SET @P_id = ISNULL((SELECT person_id FROM doctor WHERE id = @Id),0)
	
    DELETE FROM dbo.doctor WHERE id = @Id
	
	DELETE FROM dbo.person WHERE id = @P_id
	
	UPDATE dbo.cure 
		SET
			doc_id = -1
	WHERE id = @Id
	
	UPDATE dbo.measure 
		SET
			doc_id = -1
	WHERE id = @Id
	
	UPDATE dbo.diagnostic 
		SET
			doc_id = -1
	WHERE id = @Id
END
GO


----------------------------company-----------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_company_Add')
DROP PROCEDURE dias_company_Add
GO
CREATE PROCEDURE dias_company_Add
    @Name varchar(50),
	@Activity varchar(100),
	@Risk varchar(20)
AS
BEGIN
    DECLARE @Id int
	SET @Id = ISNULL((SELECT MAX(id) FROM company),0) + 1
	
	INSERT INTO dbo.company(id, name, activity, risk)
		VALUES(@Id, @Name, @Activity, @Risk)
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_company_Update')
DROP PROCEDURE dias_company_Update
GO
CREATE PROCEDURE dias_company_Update
	@Id int,
    @Name varchar(50),
	@Activity varchar(100),
	@Risk varchar(20)
AS
BEGIN
    UPDATE dbo.company 
		SET
			name = @Name,
			activity = @Activity,
			risk = @Risk
	WHERE id = @Id
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_company_Delete')
DROP PROCEDURE dias_company_Delete
GO
CREATE PROCEDURE dias_company_Delete
	@Id int
AS
BEGIN
	DELETE FROM dbo.company WHERE id = @Id
END
GO


----------------------------position-----------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_position_Add')
DROP PROCEDURE dias_position_Add
GO
CREATE PROCEDURE dias_position_Add
    @Name varchar(100),
	@Lvl varchar(20)
AS
BEGIN
    DECLARE @Id int
	SET @Id = ISNULL((SELECT MAX(id) FROM position),0) + 1
	
	INSERT INTO dbo.position(id, name, lvl)
		VALUES(@Id, @Name, @Lvl)
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_position_Update')
DROP PROCEDURE dias_position_Update
GO
CREATE PROCEDURE dias_position_Update
    @Name varchar(100),
	@Lvl varchar(20)
AS
BEGIN
    UPDATE dbo.position 
		SET
			lvl = @Lvl
	WHERE name = @Name
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_position_Delete')
DROP PROCEDURE dias_position_Delete
GO
CREATE PROCEDURE dias_position_Delete
	@Name int
AS
BEGIN
	DELETE FROM dbo.position WHERE name = @Name
END
GO


----------------------------meds-----------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_meds_Add')
DROP PROCEDURE dias_meds_Add
GO
CREATE PROCEDURE dias_meds_Add
    @Med_type varchar(100),
	@Name varchar(20)
AS
BEGIN
    DECLARE @Id int
	SET @Id = ISNULL((SELECT MAX(id) FROM meds),0) + 1
	
	INSERT INTO dbo.meds(id, med_type, name)
		VALUES(@Id, @Med_type, @Name)
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_meds_Update')
DROP PROCEDURE dias_meds_Update
GO
CREATE PROCEDURE dias_meds_Update
    @Med_type varchar(100),
	@Name varchar(20)
AS
BEGIN
    DECLARE @Id int
	SET @Id = ISNULL((SELECT id FROM meds WHERE name = @Name),0)
	
	UPDATE dbo.meds 
		SET
			med_type = @Med_type,
			name = @Name
	WHERE id = @Id
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_meds_Delete')
DROP PROCEDURE dias_meds_Delete
GO
CREATE PROCEDURE dias_meds_Delete
	@Name int
AS
BEGIN
	DELETE FROM dbo.meds WHERE name = @Name
END
GO


----------------------------cure-----------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_cure_Add')
DROP PROCEDURE dias_cure_Add
GO
CREATE PROCEDURE dias_cure_Add
	@P_Id int,
	@D_Id int,
	@M_Id int,
	@Date1 date,
	@Date2 date
AS
BEGIN
    DECLARE @Id int
	SET @Id = ISNULL((SELECT MAX(id) FROM cure),0) + 1
	
	INSERT INTO dbo.cure(id, patient_id, doc_id, meds_id, date_start, date_end)
		VALUES(@Id, @P_Id, @D_Id, @M_Id, @Date1, @Date2)
END
GO


----------------------------measure-----------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_measure_Add')
DROP PROCEDURE dias_measure_Add
GO
CREATE PROCEDURE dias_measure_Add
	@P_Id int,
	@D_Id int,
	@Crit_f int
AS
BEGIN
    DECLARE @Id int
	SET @Id = ISNULL((SELECT MAX(id) FROM measure),0) + 1
	
	INSERT INTO dbo.measure(id, patient_id, doc_id, crit_f)
		VALUES(@Id, @P_Id, @D_Id, @Crit_f)
END
GO


----------------------------diagnostic-----------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'dias_diagnostic_Add')
DROP PROCEDURE dias_diagnostic_Add
GO
CREATE PROCEDURE dias_diagnostic_Add
	@P_Id int,
	@D_Id int,
	@Analysys varchar(100),
	@Proc_done varchar(100),
	@Diagnosis varchar(2500),
	@D_comment varchar(5000),
	@Date1 date,
	@Date2 date
AS
BEGIN
    DECLARE @Id int
	SET @Id = ISNULL((SELECT MAX(id) FROM diagnostic),0) + 1
	
	INSERT INTO dbo.diagnostic(id, patient_id, doc_id, analysis, proc_done, diagnosis, d_comment, lat_visit, suspend_till)
		VALUES(@Id, @P_Id, @D_Id, @Analysys, @Proc_done, @Diagnosis, @D_comment, @Date1, @Date2)
END                                          
GO                                           









