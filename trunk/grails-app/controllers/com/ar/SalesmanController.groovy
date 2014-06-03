package com.app
import com.ar.EmployeeData

class EmployeeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def appSearchService
    def appUtilityService

    def beforeInterceptor = [action:this.&auth]

    def auth() {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def employee = new Employee()
        employee.properties = params.properties
        def party = new Party()
        party.properties = params.properties
        
        def offset = 0
        def result = appSearchService.getEmployees(
            params.name, params.firstName, params.middleName, params.lastName, params.tin, employee.department, employee.position
        )

        if(params.offset){
            offset = Math.min(params.offset ? params.int('offset') : 0, result.size())
        }
        //Record Count - if sql query is used
        def recordCount = offset + params.max
        if(recordCount >= result.size()){
            recordCount = result.size()
        }
        [employeeInstanceList: result.subList(offset, recordCount), employeeInstanceTotal: result.size(), employeeInstance: employee, partyInstance: party, recordCount: recordCount]
    }

    def create = {
        def employeeData = new EmployeeData()
        return [employeeData: employeeData]
    }

    def save = { EmployeeData data ->
        def employeeInstance = new Employee(params)
        def partyInstance = new Party()
        def personInstance = new Person(params)
        def partyRole = new PartyRole(params)

        bindData(data, params)
        data.status = 'Active'
        def empRole = AppRole.findByRoleCode('SALES')
        data.roleId = empRole.id
        data.fullName = data.firstName + ' ' + data.middleName + ' ' + data.lastName
        if(data.validate()){

            partyInstance.name = data.fullName
            partyInstance.lastName = data.lastName
            partyInstance.firstName = data.firstName
            partyInstance.middleName = data.middleName
            partyInstance.tin = data.tin
            partyInstance.save(flush:true)

            personInstance.party = Party.get(partyInstance.id)
            personInstance.lastName = data.lastName
            personInstance.firstName = data.firstName
            personInstance.middleName = data.middleName
            personInstance.gender = data.gender
            personInstance.nickname = data.firstName
            personInstance.personalTitle = data.personalTitle
            personInstance.maritalStatus = data.maritalStatus
            personInstance.save(flush:true)

            employeeInstance.party = Party.get(partyInstance.id)
            employeeInstance.department = data.department
            employeeInstance.position = data.position
            employeeInstance.status = 'Active'
            employeeInstance.save(flush:true)

            partyRole.party = Party.get(partyInstance.id)
            partyRole.fromDate = new Date()
            partyRole.status = 'Active'
            
            partyRole.role = empRole
            partyRole.save(flush:true)

            appUtilityService.createContactEntries(data, Party.get(partyInstance.id))

            flash.message = "${message(code: 'default.created.message', args: [message(code: 'employee.label', default: 'Employee'), partyInstance.name])}"
            redirect(action: "show", id: employeeInstance.id)
        } else {
            render(view: "create", model : [employeeData: data])
            return 
        }
    }

    def show = {
        def employeeInstance = Employee.get(params.id)

        def employeeData = appUtilityService.prepareEmployeeData(employeeInstance)

        if (!employeeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])}"
            redirect(action: "list")
        }
        else {
            [employeeData: employeeData]
        }
    }

    def edit = {
        def employeeInstance = Employee.get(params.id)

        def employeeData = appUtilityService.prepareEmployeeData(employeeInstance)

        if (!employeeData) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [employeeData: employeeData]
        }
    }

    def update = { EmployeeData data ->

        bindData(data, params)
        data.fullName = data.firstName + ' ' + data.middleName + ' ' + data.lastName
        
        def empRole = AppRole.findByRoleCode('SALES')
        data.roleId = empRole.id

        if(data.validate()){

            def partyInstance = Party.get(data.partyId);
            partyInstance.name = data.fullName
            partyInstance.lastName = data.lastName
            partyInstance.firstName = data.firstName
            partyInstance.middleName = data.middleName
            partyInstance.tin = data.tin
            partyInstance.save(flush:true)

            def personInstance = Person.get(data.personId)
            personInstance.lastName = data.lastName
            personInstance.firstName = data.firstName
            personInstance.middleName = data.middleName
            personInstance.gender = data.gender
            personInstance.nickname = data.firstName
            personInstance.personalTitle = data.personalTitle
            personInstance.maritalStatus = data.maritalStatus
            personInstance.save(flush:true)

            def employeeInstance = Employee.get(data.empId)
            employeeInstance.department = data.department
            employeeInstance.position = data.position
            employeeInstance.status = data.status
            employeeInstance.save(flush:true)

            if(data.status == 'Inactive'){
                def partyRole = PartyRole.findByParty(partyInstance)
                if (partyRole != null) {
                    partyRole.status = 'Inactive'
                    partyRole.thruDate = new Date()
                    partyROle.save(flush:true)
                }
            }
            
            appUtilityService.updateContactEntries(data)

            flash.message = "${message(code: 'default.updated.message', args: [message(code: 'employee.label', default: 'Employee'), partyInstance.name])}"
            redirect(action: "show", id: employeeInstance.id)

        } else {
            render(view: "edit", model : [employeeData: data])
            return 
        }
    }

    def delete = {
        def employeeInstance = Employee.get(params.id)
        if (employeeInstance) {
            try {
                employeeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])}"
            redirect(action: "list")
        }
    }
}