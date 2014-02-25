package com.app

import groovy.sql.Sql

class AppUtilityService {

	static transactional = true

    def dataSource

    def serviceMethod() {

    }

    def prepareEmployeeData(Employee employeeInstance){

    	def employeeData = new EmployeeData();

        println 'employee id : ' + employeeInstance.id

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

        return employeeData

    }

}
