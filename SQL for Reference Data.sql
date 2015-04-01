
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

-- begin app_organization

SELECT 'BEFORE APP_ORGANIZATION' AS 'BEFORE APP_ORGANIZATION',* FROM APP_ORGANIZATION

INSERT INTO dbo.app_organization (version, logo_path, organization_code, organization_name, organization_type, party_id)
VALUES (1, '', 'TEST', 'Public Organization', 'Public Organization', 2)

SELECT 'AFTER APP_ORGANIZATION' AS 'AFTER APP_ORGANIZATION',* FROM APP_ORGANIZATION

-- end app_organization

-- begin approval

SELECT 'BEFORE APPROVAL' AS 'BEFORE APPROVAL', * FROM APPROVAL

INSERT INTO dbo.approval (version, active, approval_feature, department, submit_by_position, description)
VALUES (0, 'Yes', 'Voucher Approval', 'Finance', 'Clerk', 'Finance Clerk submission for voucher approval')

INSERT INTO dbo.approval (version, active, approval_feature, department, submit_by_position, description)
VALUES (0, 'Yes', 'Voucher Approval', 'Finance', 'Supervisor', 'Finance Supervisor submission for voucher approval')


INSERT INTO dbo.approval (version, active, approval_feature, department, submit_by_position, description)
VALUES (0, 'Yes', 'Voucher Approval', 'Finance', 'Manager', 'Finance Manager submission for voucher approval')

SELECT 'AFTER APPROVAL' AS 'AFTER APPROVAL', * FROM APPROVAL

-- end approval

-- begin approval_seq

SELECT 'BEFORE APPROVAL' AS 'BEFORE APPROVAL', * FROM approval_seq


 --remarks (inList: ['Noted By', 'Approved By', 'Reviewed By'])
INSERT INTO dbo.approval_seq (version, approval_id, position, remarks, sequence, status)
VALUES (0, 1, 'Clerk', '', 1)

INSERT INTO dbo.approval_seq (version, approval_id, position, remarks, sequence, status)
VALUES (0, 1, 'Supervisor', '', 1)

INSERT INTO dbo.approval_seq (version, approval_id, position, remarks, sequence, status)
VALUES (0, 1, 'Manager', '', 1)


SELECT 'AFTER APPROVAL' AS 'AFTER APPROVAL', * FROM approval_seq

















