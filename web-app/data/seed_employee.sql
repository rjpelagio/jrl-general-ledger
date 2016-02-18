BEGIN

	DECLARE @generatedId INT 

	IF NOT EXISTS (
		SELECT contact_mech.contact_mech_id FROM dbo.party_contact_mech 
		JOIN party ON party.party_id = party_contact_mech.party_id
		JOIN contact_mech ON contact_mech.contact_mech_id = party_contact_mech.contact_mech_id
		WHERE party.name = 'RJ Pelagio'
	)
		BEGIN

			-- Address --

			INSERT INTO dbo.contact_mech (version, contact_mech_type)
			VALUES (0, 'POSTAL_ADDRESS')

			SET @generatedId = SCOPE_IDENTITY()

			INSERT INTO dbo.party_contact_mech (version, contact_mech_id, contact_mech_type, from_date, party_id, purpose)
			VALUES (0, @generatedId, 'POSTAL_ADDRESS', getDate(), (SELECT party_id FROM party WHERE name = 'RJ Pelagio'), 'Home Address')

			INSERT INTO dbo.postal_address (version, address_line1, address_line2, city, contact_mech_id, postal_code, province)
			VALUES (0, '357 St Mark Street', 'St Augustine Village', 'Calamba', @generatedId, '4027', 'Laguna')

			INSERT INTO dbo.contact_mech (version, contact_mech_type)
			VALUES (0, 'PHONE_INFO')

			SET @generatedId = SCOPE_IDENTITY()

			INSERT INTO dbo.party_contact_mech (version, contact_mech_id, contact_mech_type, from_date, party_id, purpose)
			VALUES (0, @generatedId, 'PHONE_INFO', getDate(), (SELECT party_id FROM party WHERE name = 'RJ Pelagio'), 'Home Phone')

			INSERT INTO dbo.tele_info (version, area_code, contact_mech_id, contact_number, contact_person, date_created, last_updated, mobile_number)
			VALUES (0, '049', @generatedId, '5022597', 'Jephy', getDate(), getDate(), '09174729235')

			INSERT INTO dbo.contact_mech (version, contact_mech_type)
			VALUES (0, 'EMAIL_ADDRESS')

			SET @generatedId = SCOPE_IDENTITY()

			INSERT INTO dbo.party_contact_mech (version, contact_mech_id, contact_mech_type, from_date, party_id, purpose)
			VALUES (0, @generatedId, 'EMAIL_ADDRESS', getDate(), (SELECT party_id FROM party WHERE name = 'RJ Pelagio'), 'Email Address')

			INSERT INTO dbo.elec_address (version, contact_mech_id, email_string)
			VALUES (0, @generatedId, 'rjpelagio@gmail.com')

		END 

	IF NOT EXISTS (
		SELECT contact_mech.contact_mech_id FROM dbo.party_contact_mech 
		JOIN party ON party.party_id = party_contact_mech.party_id
		JOIN contact_mech ON contact_mech.contact_mech_id = party_contact_mech.contact_mech_id
		WHERE party.name = 'Yna Macaspac'
	)
		BEGIN

			-- Address --

			INSERT INTO dbo.contact_mech (version, contact_mech_type)
			VALUES (0, 'POSTAL_ADDRESS')

			SET @generatedId = SCOPE_IDENTITY()

			INSERT INTO dbo.party_contact_mech (version, contact_mech_id, contact_mech_type, from_date, party_id, purpose)
			VALUES (0, @generatedId, 'POSTAL_ADDRESS', getDate(), (SELECT party_id FROM party WHERE name = 'Yna Macaspac'), 'Home Address')

			INSERT INTO dbo.postal_address (version, address_line1, address_line2, city, contact_mech_id, postal_code, province)
			VALUES (0, '41 Binondo Drive', 'P Tuazon corner Edsa', 'Mandaluyong City', @generatedId, '4027', 'NCR')

			INSERT INTO dbo.contact_mech (version, contact_mech_type)
			VALUES (0, 'PHONE_INFO')

			SET @generatedId = SCOPE_IDENTITY()

			INSERT INTO dbo.party_contact_mech (version, contact_mech_id, contact_mech_type, from_date, party_id, purpose)
			VALUES (0, @generatedId, 'PHONE_INFO', getDate(), (SELECT party_id FROM party WHERE name = 'Yna Macaspac'), 'Home Phone')

			INSERT INTO dbo.tele_info (version, area_code, contact_mech_id, contact_number, contact_person, date_created, last_updated, mobile_number)
			VALUES (0, '02', @generatedId, '8475521', 'Jephy', getDate(), getDate(), '09174729235')

			INSERT INTO dbo.contact_mech (version, contact_mech_type)
			VALUES (0, 'EMAIL_ADDRESS')

			SET @generatedId = SCOPE_IDENTITY()

			INSERT INTO dbo.party_contact_mech (version, contact_mech_id, contact_mech_type, from_date, party_id, purpose)
			VALUES (0, @generatedId, 'EMAIL_ADDRESS', getDate(), (SELECT party_id FROM party WHERE name = 'Yna Macaspac'), 'Email Address')

			INSERT INTO dbo.elec_address (version, contact_mech_id, email_string)
			VALUES (0, @generatedId, 'rjpelagio@gmail.com')

		END 

	IF NOT EXISTS (
		SELECT contact_mech.contact_mech_id FROM dbo.party_contact_mech 
		JOIN party ON party.party_id = party_contact_mech.party_id
		JOIN contact_mech ON contact_mech.contact_mech_id = party_contact_mech.contact_mech_id
		WHERE party.name = 'Clara del Valle'
	)
		BEGIN

			-- Address --

			INSERT INTO dbo.contact_mech (version, contact_mech_type)
			VALUES (0, 'POSTAL_ADDRESS')

			SET @generatedId = SCOPE_IDENTITY()

			INSERT INTO dbo.party_contact_mech (version, contact_mech_id, contact_mech_type, from_date, party_id, purpose)
			VALUES (0, @generatedId, 'POSTAL_ADDRESS', getDate(), (SELECT party_id FROM party WHERE name = 'Clara del Valle'), 'Home Address')

			INSERT INTO dbo.postal_address (version, address_line1, address_line2, city, contact_mech_id, postal_code, province)
			VALUES (0, '22nd Street', 'Corazon Ave', 'Marikina City', @generatedId, '4027', 'NCR')

			INSERT INTO dbo.contact_mech (version, contact_mech_type)
			VALUES (0, 'PHONE_INFO')

			SET @generatedId = SCOPE_IDENTITY()

			INSERT INTO dbo.party_contact_mech (version, contact_mech_id, contact_mech_type, from_date, party_id, purpose)
			VALUES (0, @generatedId, 'PHONE_INFO', getDate(), (SELECT party_id FROM party WHERE name = 'Clara del Valle'), 'Home Phone')

			INSERT INTO dbo.tele_info (version, area_code, contact_mech_id, contact_number, contact_person, date_created, last_updated, mobile_number)
			VALUES (0, '02', @generatedId, '2036021', 'Jephy', getDate(), getDate(), '09174729235')

			INSERT INTO dbo.contact_mech (version, contact_mech_type)
			VALUES (0, 'EMAIL_ADDRESS')

			SET @generatedId = SCOPE_IDENTITY()

			INSERT INTO dbo.party_contact_mech (version, contact_mech_id, contact_mech_type, from_date, party_id, purpose)
			VALUES (0, @generatedId, 'EMAIL_ADDRESS', getDate(), (SELECT party_id FROM party WHERE name = 'Clara del Valle'), 'Email Address')

			INSERT INTO dbo.elec_address (version, contact_mech_id, email_string)
			VALUES (0, @generatedId, 'rjpelagio@gmail.com')

		END 

	IF NOT EXISTS (SELECT party_role.party_id, party_role.role_id, app_role.role_code
		FROM party_role 
		JOIN party ON party.party_id = party_role.party_id 
		JOIN app_role ON app_role.id = party_role.role_id
		WHERE party.name = 'RJ Pelagio'
	)
		BEGIN
			INSERT INTO party_role (version, party_id, role_id, from_date, status)
			VALUES (0,
				(SELECT party_id FROM party WHERE name = 'RJ Pelagio'),
				(SELECT id FROM app_role WHERE role_code = 'EMP'),
				getDate(),
				'Active'
			)

		END

	IF NOT EXISTS (SELECT party_role.party_id, party_role.role_id, app_role.role_code
		FROM party_role 
		JOIN party ON party.party_id = party_role.party_id 
		JOIN app_role ON app_role.id = party_role.role_id
		WHERE party.name = 'Yna Macaspac'
	)
		BEGIN
			INSERT INTO party_role (version, party_id, role_id, from_date, status)
			VALUES (0,
				(SELECT party_id FROM party WHERE name = 'Yna Macaspac'),
				(SELECT id FROM app_role WHERE role_code = 'EMP'),
				getDate(),
				'Active'
			)
		END

	IF NOT EXISTS (SELECT party_role.party_id, party_role.role_id, app_role.role_code
		FROM party_role 
		JOIN party ON party.party_id = party_role.party_id 
		JOIN app_role ON app_role.id = party_role.role_id
		WHERE party.name = 'Clara del Valle'
	)
		BEGIN
			INSERT INTO party_role (version, party_id, role_id, from_date, status)
			VALUES (0,
				(SELECT party_id FROM party WHERE name = 'Clara del Valle'),
				(SELECT id FROM app_role WHERE role_code = 'EMP'),
				getDate(),
				'Active'
			)

		END

END
