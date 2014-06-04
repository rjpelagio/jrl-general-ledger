--REFERENCE DATA

--app_role

SELECT 'BEFORE APP_ROLE' AS 'BEFORE APP_ROLE',* FROM app_role

BEGIN TRANSACTION 

DECLARE @generatedId  int,
		@userId int

INSERT INTO dbo.app_role (version, date_created, last_updated, parent_id, role_code, role_name)
VALUES (0, 3/1/2014, 3/1/2014, NULL, 'USR', 'User')

INSERT INTO dbo.app_role (version, date_created, last_updated, parent_id, role_code, role_name)
VALUES (0, 3/1/2014, 3/1/2014, NULL, 'BUSR', 'Basic User')

SET @userId =
	(
		SELECT id
		FROM app_role
		WHERE role_code = 'USR'
	)

UPDATE app_role SET parent_id = @userId
WHERE role_code = 'ADM' OR role_code = 'SUSER' OR role_code = 'BUSR'

INSERT INTO dbo.app_role (version, date_created, last_updated, parent_id, role_code, role_name)
VALUES (0, 3/1/2014, 3/1/2014, NULL, 'GRP', 'Group')

SET @generatedId = 
    (
       SELECT id 
       FROM app_role 
       WHERE role_code = 'GRP'
    ) 

INSERT INTO dbo.app_role (version, date_created, last_updated, parent_id, role_code, role_name)
VALUES (0, 3/1/2014, 3/1/2014, @generatedId, 'EMP', 'Employee')

INSERT INTO dbo.app_role (version, date_created, last_updated, parent_id, role_code, role_name)
VALUES (0, 3/1/2014, 3/1/2014, @generatedId, 'CUST', 'Customer')

INSERT INTO dbo.app_role (version, date_created, last_updated, parent_id, role_code, role_name)
VALUES (0, 3/1/2014, 3/1/2014, @generatedId, 'SUPP', 'Supplier')

INSERT INTO dbo.app_role (version, date_created, last_updated, parent_id, role_code, role_name)
VALUES (0, 3/1/2014, 3/1/2014, @generatedId, 'ORG', 'Organization')

INSERT INTO dbo.app_role (version, date_created, last_updated, parent_id, role_code, role_name)
VALUES (0, 3/1/2014, 3/1/2014, @generatedId, 'SLM', 'Salesman')

IF @@ERROR > 1 
	ROLLBACK TRANSACTION
ELSE 
	COMMIT TRANSACTION
GO

SELECT 'AFTER APP_ROLE' AS 'AFTER APP_ROLE',* FROM app_role

-- end app_role