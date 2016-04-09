BEGIN

	-- APPROVAL FOR VOUCHER SEED DATA

	DECLARE @generatedId INT 

	IF NOT EXISTS (SELECT 1 FROM dbo.approval WHERE approval_feature = 'DISBURSEMENT' 
		AND department = 'Finance' AND position = 'Clerk')
	BEGIN
		INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
		VALUES (1, 'Clerk approval template for Disbursement', 'Finance', 'DISBURSEMENT', 'Active', 'Clerk')

		SET @generatedId = SCOPE_IDENTITY()

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Manager', 1)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Supervisor', 2)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Clerk', 3)
	END

	IF NOT EXISTS (SELECT 1 FROM dbo.approval WHERE approval_feature = 'DISBURSEMENT' 
		AND department = 'Finance' AND position = 'Supervisor')
	BEGIN
		INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
		VALUES (1, 'Supervisor approval template for Disbursement', 'Finance', 'DISBURSEMENT', 'Active', 'Supervisor')

		SET @generatedId = SCOPE_IDENTITY()

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Manager', 1)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Supervisor', 2)
	END

	IF NOT EXISTS (SELECT 1 FROM dbo.approval WHERE approval_feature = 'DISBURSEMENT' 
		AND department = 'Finance' AND position = 'Manager')
	BEGIN
		
		INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
		VALUES (1, 'Manager approval template for Disbursement', 'Finance', 'DISBURSEMENT', 'Active', 'Manager')

		SET @generatedId = SCOPE_IDENTITY()

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (0, @generatedId, 'Manager', 1)
	END

	-- Salesman cash advance and reimbursement approval
	IF NOT EXISTS (SELECT 1 FROM dbo.approval WHERE approval_feature = 'CASH_ADVANCE' 
		AND department = 'Sales' AND position = 'Clerk')
	BEGIN
		INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
		VALUES (1, 'Salesman approval template for cash', 'Sales', 'CASH_ADVANCE', 'Active', 'Clerk')

		SET @generatedId = SCOPE_IDENTITY()

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Manager', 1)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Supervisor', 2)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Clerk', 3)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Clerk', 4)
	END


	IF NOT EXISTS (SELECT 1 FROM dbo.approval WHERE approval_feature = 'VOUCHER' 
		AND department = 'Finance' AND position = 'Clerk')
	BEGIN
		INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
		VALUES (1, 'Clerk approval template for voucher', 'Finance', 'VOUCHER', 'Active', 'Clerk')

		SET @generatedId = SCOPE_IDENTITY()

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Manager', 1)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Supervisor', 2)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Clerk', 3)
	END

	IF NOT EXISTS (SELECT 1 FROM dbo.approval WHERE approval_feature = 'VOUCHER' 
		AND department = 'Finance' AND position = 'Supervisor')
	BEGIN
		INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
		VALUES (1, 'Supervisor approval template for voucher', 'Finance', 'VOUCHER', 'Active', 'Supervisor')

		SET @generatedId = SCOPE_IDENTITY()

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Manager', 1)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Supervisor', 2)
	END

	IF NOT EXISTS (SELECT 1 FROM dbo.approval WHERE approval_feature = 'VOUCHER' 
		AND department = 'Finance' AND position = 'Manager')
	BEGIN
		
		INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
		VALUES (1, 'Manager approval template for voucher', 'Finance', 'VOUCHER', 'Active', 'Manager')

		SET @generatedId = SCOPE_IDENTITY()

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (0, @generatedId, 'Manager', 1)
	END

	-- APPROVAL FOR CASH ADVANCE SEED DATA

	IF NOT EXISTS (SELECT 1 FROM dbo.approval WHERE approval_feature = 'CASH_ADVANCE' 
		AND department = 'Finance' AND position = 'Clerk')
	BEGIN
		INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
		VALUES (1, 'Clerk approval template for cash advance', 'Finance', 'CASH_ADVANCE', 'Active', 'Clerk')

		SET @generatedId = SCOPE_IDENTITY()

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Manager', 1)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Supervisor', 2)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Clerk', 3)
	END

	IF NOT EXISTS (SELECT 1 FROM dbo.approval WHERE approval_feature = 'CASH_ADVANCE' 
		AND department = 'Finance' AND position = 'Supervisor')
	BEGIN
		INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
		VALUES (1, 'Supervisor approval template for cash advance', 'Finance', 'CASH_ADVANCE', 'Active', 'Supervisor')

		SET @generatedId = SCOPE_IDENTITY()

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Manager', 1)

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (1, @generatedId, 'Supervisor', 2)
	END

	IF NOT EXISTS (SELECT 1 FROM dbo.approval WHERE approval_feature = 'CASH_ADVANCE' 
		AND department = 'Finance' AND position = 'Manager')
	BEGIN
		
		INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
		VALUES (1, 'Manager approval template for cash advance', 'Finance', 'CASH_ADVANCE', 'Active', 'Manager')

		SET @generatedId = SCOPE_IDENTITY()

		INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
		VALUES (0, @generatedId, 'Manager', 1)
	END

	-- APPROLE SEED DATA

	IF NOT EXISTS (SELECT 1 FROM dbo.app_role WHERE role_code = 'USR' AND role_name = 'User')
		BEGIN
			INSERT INTO dbo.app_role (version, role_code, date_created, last_updated, role_name, parent_id)
			VALUES(1,'USR', getDate(), getDate(), 'User',NULL)

			SET @generatedId = SCOPE_IDENTITY()
		END

	IF NOT EXISTS (SELECT 1 FROM dbo.app_role WHERE role_code = 'ADM' AND role_name = 'Admin')
		BEGIN
			INSERT INTO dbo.app_role (version, role_code, date_created, last_updated, role_name, parent_id)
			VALUES(1,'ADM', getDate(), getDate(), 'Admin',@generatedId)
		END

	IF NOT EXISTS (SELECT 1 FROM dbo.app_role WHERE role_code = 'SUSER' AND role_name = 'Super User')
		BEGIN
			INSERT INTO dbo.app_role (version, role_code, date_created, last_updated, role_name, parent_id)
			VALUES(1,'SUSER', getDate(), getDate(), 'Super User',@generatedId)
		END

	IF NOT EXISTS (SELECT 1 FROM dbo.app_role WHERE role_code = 'GRP' AND role_name = 'Group')
		BEGIN
			INSERT INTO dbo.app_role (version, role_code, date_created, last_updated, role_name, parent_id)
			VALUES(1,'GRP', getDate(), getDate(), 'Group',NULL)
		
			SET @generatedId = SCOPE_IDENTITY()
		END

	IF NOT EXISTS (SELECT 1 FROM dbo.app_role WHERE role_code = 'EMP' AND role_name = 'Employee')
		BEGIN
			INSERT INTO dbo.app_role (version, role_code, date_created, last_updated, role_name, parent_id)
			VALUES(1,'EMP', getDate(), getDate(), 'Employee',@generatedId)
		END

	IF NOT EXISTS (SELECT 1 FROM dbo.app_role WHERE role_code = 'CUST' AND role_name = 'Customer')
		BEGIN
			INSERT INTO dbo.app_role (version, role_code, date_created, last_updated, role_name, parent_id)
			VALUES(1,'CUST', getDate(), getDate(), 'Customer',@generatedId)
		END

	IF NOT EXISTS (SELECT 1 FROM dbo.app_role WHERE role_code = 'SUPP' AND role_name = 'Supplier')
		BEGIN
			INSERT INTO dbo.app_role (version, role_code, date_created, last_updated, role_name, parent_id)
			VALUES(1,'SUPP', getDate(), getDate(), 'Supplier',@generatedId)
		END

	IF NOT EXISTS (SELECT 1 FROM dbo.app_role WHERE role_code = 'ORG' AND role_name = 'Organization')
		BEGIN
			INSERT INTO dbo.app_role (version, role_code, date_created, last_updated, role_name, parent_id)
			VALUES(1,'ORG', getDate(), getDate(), 'Organization',@generatedId)
		END

	IF NOT EXISTS (SELECT 1 FROM dbo.app_role WHERE role_code = 'SLM' AND role_name = 'Salesman')
		BEGIN
			INSERT INTO dbo.app_role (version, role_code, date_created, last_updated, role_name, parent_id)
			VALUES(1,'SLM', getDate(), getDate(), 'Salesman',@generatedId)
		END


END