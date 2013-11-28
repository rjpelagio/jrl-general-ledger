package com.app

class EmployeeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def appSearchService

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
        def employeeInstance = new Employee()
        def partyInstance = new Party()
        def personInstance = new Person()
        partyInstance.properties = params
        employeeInstance.properties = params
        personInstance.properties = params
        return [employeeInstance: employeeInstance, partyInstance: partyInstance]
    }

    def save(EmployeeData data) {
        def employeeInstance = new Employee(params)
        def partyInstance = new Party()
        def personInstance = new Person(params)

        if (data.hasErrors()) {
            render(view: "create", model: [employeeData: data])
            return
        }

        partyInstance.name = params.name
        partyInstance.lastName = params.lastName
        partyInstance.firstName = params.firstName
        partyInstance.middleName = params.middleName
        partyInstance.tin = params.tin

        personInstance.lastName = params.lastName
        personInstance.firstName = params.firstName
        personInstance.middleName = params.middleName
        personInstance.gender = params.gender
        personInstance.nickname = params.firstName
        personInstance.personalTitle = params.personalTitle
        personInstance.maritalStatus = params.maritalStatus

        println '0#'
        if(!partyInstance.hasErrors()){
            println '1A'
            partyInstance.save()
            employeeInstance.party = Party.get(partyInstance.id)
            personInstance.party = Party.get(partyInstance.id)
            employeeInstance.validate()
            personInstance.validate()
            if(!employeeInstance.hasErrors() && !personInstance.hasErrors()){
                println '2B'
                employeeInstance.save(flush:true);
                personInstance.save(flush:true);
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'employee.label', default: 'Employee'), partyInstance.name])}"
                redirect(action: "show", id: employeeInstance.id)
            } else {
                println '3C'
                def partyContainer = new Party();
                partyContainer = partyInstance
                partyInstance.delete();
                render(view: "create", model: [employeeInstance: employeeInstance, partyInstance: partyContainer, personInstance : personInstance])
            }
        } else {
            println '4D'
            render(view: "create", model: [employeeInstance: employeeInstance, partyInstance: partyInstance, personInstance : personInstance])
        }
    }

    def show = {
        def employeeInstance = Employee.get(params.id)
        if (!employeeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])}"
            redirect(action: "list")
        }
        else {
            [employeeInstance: employeeInstance]
        }
    }

    def edit = {
        def employeeInstance = Employee.get(params.id)
        if (!employeeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [employeeInstance: employeeInstance]
        }
    }

    def update = {
        def employeeInstance = Employee.get(params.id)
        def party = employeeInstance.party
        def partyInstance = Party.find(party)
        
        if (employeeInstance && partyInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (employeeInstance.version > version) {
                    
                    employeeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'employee.label', default: 'Employee')] as Object[], "Another user has updated this Employee while you were editing")
                    render(view: "edit", model: [employeeInstance: employeeInstance])
                    return
                }
            }
            partyInstance.name = params.name
            partyInstance.lastName = params.lastName
            partyInstance.firstName = params.firstName
            partyInstance.middleName = params.middleName
            partyInstance.tin = params.tin
            if (!partyInstance.hasErrors() && partyInstance.save(flush: true)) {
                employeeInstance.properties = params
                if (!employeeInstance.hasErrors() && employeeInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'employee.label', default: 'Employee'), employeeInstance.id])}"
                    redirect(action: "show", id: employeeInstance.id)
                }
            }
            else {
                render(view: "edit", model: [employeeInstance: employeeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])}"
            redirect(action: "list")
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