BEGIN
	CREATE TRIGGER insVoucherApproval ON [dbo].[gl_accounting_transaction] 
	AFTER INSERT
	AS

		DECLARE @status VARCHAR(20);
		SELECT @status = i.status FROM inserted i;
		
		IF @status = 'Submitted'
		BEGIN

			DECLARE @organization_id INT;
			DECLARE @transaction_id INT;
			DECLARE @user_id INT;
			SELECT @user_id=i.prepared_by_id FROM inserted i; 
			SELECT @organization_id = i.organization_id FROM inserted i;	
			SELECT @transaction_id = i.id FROM inserted i;
			
			
			DECLARE @department VARCHAR(20);
			DECLARE @position VARCHAR(20);
			DECLARE @name VARCHAR(50);
			
			SELECT @department= department, @position = position
			FROM employee
			WHERE employee.party_id = @user_id
			
			SELECT @name = name
			FROM party
			WHERE party.party_id = @user_id
			
			DECLARE @approval_id INT;
			SELECT @approval_id = id
			FROM approval
			WHERE department = @department 
				AND position = @position
				
			
			INSERT INTO voucher_approval (version, updated_by_id, sequence, transaction_id, last_updated, remarks, position, status)
			SELECT 1, 
			(SELECT ISNULL(emp.party_id,NULL) 
				FROM employee emp 
				WHERE emp.party_id = @user_id
					AND approval_seq.position = emp.position),
			approval_seq.sequence, 
			@transaction_id, 
			--getdate(), 
			(SELECT ISNULL(getdate(),NULL) 
				FROM employee emp 
				WHERE emp.party_id = @user_id
					AND approval_seq.position = emp.position),
			--'Prepared By ' + @name
			(SELECT ISNULL('Prepared by ' + @name,'') 
				FROM employee emp 
				WHERE emp.party_id = @user_id
					AND approval_seq.position = emp.position),
			approval_seq.position,
			ISNULL ((SELECT ISNULL('Submitted', '')
				FROM employee emp
				WHERE emp.party_id = @user_id
					AND approval_seq.position = emp.position), 'Active')
			FROM approval_seq
			WHERE approval_seq.approval_id = @approval_id

			
			PRINT 'AFTER INSERT trigger fired.'
		END
END

BEGIN
	CREATE TRIGGER insVoucherApprovalOnUpd ON [dbo].[gl_accounting_transaction] 
	AFTER UPDATE
	AS

		DECLARE @status VARCHAR(20);
		SELECT @status = i.status FROM inserted i;
		
		IF @status = 'Submitted'
		BEGIN

			DECLARE @organization_id INT;
			DECLARE @transaction_id INT;
			DECLARE @user_id INT;
			SELECT @user_id=i.prepared_by_id FROM inserted i; 
			SELECT @organization_id = i.organization_id FROM inserted i;	
			SELECT @transaction_id = i.id FROM inserted i;
			
			
			DECLARE @department VARCHAR(20);
			DECLARE @position VARCHAR(20);
			DECLARE @name VARCHAR(50);
			
			SELECT @department= department, @position = position
			FROM employee
			WHERE employee.party_id = @user_id
			
			SELECT @name = name
			FROM party
			WHERE party.party_id = @user_id
			
			DECLARE @approval_id INT;
			SELECT @approval_id = id
			FROM approval
			WHERE department = @department 
				AND position = @position
				
			
			INSERT INTO voucher_approval (version, updated_by_id, sequence, transaction_id, last_updated, remarks, position, status)
			SELECT 1, 
			(SELECT ISNULL(emp.party_id,NULL) 
				FROM employee emp 
				WHERE emp.party_id = @user_id
					AND approval_seq.position = emp.position),
			approval_seq.sequence, 
			@transaction_id, 
			--getdate(), 
			(SELECT ISNULL(getdate(),NULL) 
				FROM employee emp 
				WHERE emp.party_id = @user_id
					AND approval_seq.position = emp.position),
			--'Prepared By ' + @name
			(SELECT ISNULL('Prepared by ' + @name,'') 
				FROM employee emp 
				WHERE emp.party_id = @user_id
					AND approval_seq.position = emp.position),
			approval_seq.position,
			ISNULL ((SELECT ISNULL('Submitted', '')
				FROM employee emp
				WHERE emp.party_id = @user_id
					AND approval_seq.position = emp.position), 'Active')
			FROM approval_seq
			WHERE approval_seq.approval_id = @approval_id

			
			PRINT 'AFTER INSERT trigger fired.'
		END
END
