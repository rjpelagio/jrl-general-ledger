BEGIN

	-- Seed data for cash advance approval

	DECLARE @approvalId INT 

	INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
	VALUES (1, 'Clerk approval template for cash advance', 'Finance', 'CASH_ADVANCE', 'Active', 'Clerk')

	SET @approvalId = SCOPE_IDENTITY()

	INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
	VALUES (1, @approvalId, 'Manager', 1)

	INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
	VALUES (1, @approvalId, 'Supervisor', 2)

	INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
	VALUES (1, @approvalId, 'Clerk', 3)

	INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
	VALUES (1, 'Supervisor approval template for cash advance', 'Finance', 'CASH_ADVANCE', 'Active', 'Supervisor')

	SET @approvalId = SCOPE_IDENTITY()

	INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
	VALUES (1, @approvalId, 'Manager', 1)

	INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
	VALUES (1, @approvalId, 'Supervisor', 2)

	INSERT INTO dbo.approval (version, description, department, approval_feature, status, position)
	VALUES (1, 'Manager approval template for cash advance', 'Finance', 'CASH_ADVANCE', 'Active', 'Manager')

	SET @approvalId = SCOPE_IDENTITY()

	INSERT INTO dbo.approval_seq (version, approval_id, position, sequence)
	VALUES (0, @approvalId, 'Manager', 1)

END