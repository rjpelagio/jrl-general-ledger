package com.app

import groovy.sql.Sql

class AppUtilityService {

	static transactional = true

    def dataSource

    def serviceMethod() {

    }

    def prepareEmployeeData(Employee employeeInstance){

    	def employeeData = new EmployeeData();

    	employeeData.empId = employeeInstance.id
        employeeData.version = employeeInstance.version
    	employeeData.department = employeeInstance.department
       	employeeData.position = employeeInstance.position
        employeeData.status = employeeInstance.status

    	def partyInstance = Party.get(employeeInstance.party.id);

        employeeData.partyId = partyInstance.id
    	employeeData.fullName = partyInstance.name
        employeeData.lastName = partyInstance.lastName
        employeeData.firstName = partyInstance.firstName
        employeeData.middleName = partyInstance.middleName
        employeeData.tin = partyInstance.tin

        def personInstance = Person.findByParty(partyInstance);

        employeeData.personId = personInstance.id
        employeeData.lastName = personInstance.lastName
        employeeData.firstName = personInstance.firstName
        employeeData.middleName = personInstance.middleName
        employeeData.gender = personInstance.gender
        employeeData.birthdate = personInstance.birthdate
        employeeData.personalTitle = personInstance.personalTitle
        employeeData.maritalStatus = personInstance.maritalStatus

        def postalPartyContactMech = PartyContactMech.findByPartyAndContactMechType(partyInstance, "POSTAL_ADDRESS")

        def contactMechInstance = ContactMech.get(postalPartyContactMech.contactMechId)
        def postalAddressInstance = PostalAddress.findByContactMech(contactMechInstance)

        if (postalAddressInstance != null) {
            employeeData.contactMechId = postalPartyContactMech.contactMechId

            employeeData.postalAddressId = postalAddressInstance.id
            employeeData.addressLine1 = postalAddressInstance.addressLine1
            employeeData.addressLine2 = postalAddressInstance.addressLine2
            employeeData.city = postalAddressInstance.city
            employeeData.postalCode = postalAddressInstance.postalCode
            employeeData.province = postalAddressInstance.province
        }

        def phonePartyContactMech = PartyContactMech.findByPartyAndContactMechType(partyInstance, "PHONE_INFO")

        contactMechInstance = ContactMech.get(phonePartyContactMech.contactMechId)
        def phoneInfoInstance = TeleInfo.findByContactMech(contactMechInstance)

        if (phoneInfoInstance != null) {

            employeeData.telInfoId = phoneInfoInstance.id
            employeeData.areaCode = phoneInfoInstance.areaCode
            employeeData.contactNumber = phoneInfoInstance.contactNumber
            employeeData.contactPerson = phoneInfoInstance.contactPerson
            employeeData.mobileNumber = phoneInfoInstance.mobileNumber

        }

        def emailPartyContactMech = PartyContactMech.findByPartyAndContactMechType(partyInstance, "EMAIL_ADDRESS")

        contactMechInstance = ContactMech.get(emailPartyContactMech.contactMechId)
        def emailInfoInstance = ElecAddress.findByContactMech(contactMechInstance)

        if (emailInfoInstance != null) {

            employeeData.elecAddressId = emailInfoInstance.id
            employeeData.emailAddress = emailInfoInstance.emailString

        }

        return employeeData

    }

    def createContactEntries(EmployeeData data, Party partyInstance) {

        //ContactMech entry for Postal Address
        def contactMech = new ContactMech();
        contactMech.contactMechType = "POSTAL_ADDRESS"
        contactMech.save(flush:true)

        //PartyContactMech entry for Postal Address
        def partyContactMech = new PartyContactMech();
        partyContactMech.party = Party.get(partyInstance.id);
        partyContactMech.contactMech = ContactMech.get(contactMech.id);
        partyContactMech.fromDate = new Date();
        partyContactMech.purpose = "Postal Address for " + partyInstance.name
        partyContactMech.contactMechType = "POSTAL_ADDRESS"
        partyContactMech.save(flush:true)

        //Postal Address entry
        def postalAddress = new PostalAddress()
        postalAddress.addressLine1 = data.addressLine1
        postalAddress.addressLine2 = data.addressLine2
        postalAddress.city = data.city
        postalAddress.province = data.province
        postalAddress.postalCode = data.postalCode
        postalAddress.contactMech = ContactMech.get(contactMech.id);
        postalAddress.save(flush:true)

        //ContactMech entry for Phone Info
        contactMech = new ContactMech();
        contactMech.contactMechType = "PHONE_INFO"
        contactMech.save(flush:true)

        //PartyContactMech entry for Phone Info
        partyContactMech = new PartyContactMech();
        partyContactMech.party = Party.get(partyInstance.id);
        partyContactMech.contactMech = ContactMech.get(contactMech.id);
        partyContactMech.fromDate = new Date();
        partyContactMech.purpose = "Phone Information for " + partyInstance.name
        partyContactMech.contactMechType = "PHONE_INFO"
        partyContactMech.save(flush:true)

        //Phone Info entry
        def teleInfo = new TeleInfo()
        teleInfo.areaCode = data.areaCode
        teleInfo.contactNumber = data.contactNumber
        teleInfo.contactPerson = partyInstance.name
        teleInfo.mobileNumber = data.mobileNumber
        teleInfo.dateCreated = new Date()
        teleInfo.lastUpdated = new Date()
        teleInfo.contactMech = ContactMech.get(contactMech.id);
        teleInfo.save(flush:true)

        //ContactMech entry for Email Address
        contactMech = new ContactMech();
        contactMech.contactMechType = "EMAIL_ADDRESS"
        contactMech.save(flush:true)

        //PartyContactMech entry for Phone Info
        partyContactMech = new PartyContactMech();
        partyContactMech.party = Party.get(partyInstance.id);
        partyContactMech.contactMech = ContactMech.get(contactMech.id);
        partyContactMech.fromDate = new Date();
        partyContactMech.purpose = "Email Address for " + partyInstance.name
        partyContactMech.contactMechType = "EMAIL_ADDRESS"
        partyContactMech.save(flush:true)

        def elecAddress = new ElecAddress();
        elecAddress.emailString = data.emailAddress
        elecAddress.contactMech = ContactMech.get(contactMech.id);
        elecAddress.save(flush:true)

    }

    
    def updateContactEntries(EmployeeData data) {

        println 'Data : ' + data.postalAddressId
 
        def postalAddress = PostalAddress.get(data.postalAddressId)
        if (postalAddress != null) {
            
            postalAddress.addressLine1 = data.addressLine1
            postalAddress.addressLine2 = data.addressLine2
            postalAddress.city = data.city
            postalAddress.province = data.province
            postalAddress.postalCode = data.postalCode

            postalAddress.save(flush:true)
        }

        def phoneInfo = TeleInfo.get(data.telInfoId)

        if (phoneInfo != null) {

            phoneInfo.areaCode = data.areaCode
            phoneInfo.contactNumber = data.contactNumber
            phoneInfo.contactPerson = data.contactPerson
            phoneInfo.mobileNumber = data.mobileNumber
            phoneInfo.lastUpdated = new Date()

            phoneInfo.save(flush:true)
        }
        
        def email = ElecAddress.get(data.elecAddressId)

        if (email != null) {
            
            email.emailString = data.emailAddress

            email.save(flush:true)

        }


    }


}
