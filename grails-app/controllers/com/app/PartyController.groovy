package com.app

class PartyController {

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
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        def offset = 0
        def party = new Party()
        party.properties = params.properties;
        
        def result = appSearchService.getParty(
            party.name, party.firstName, party.middleName, party.lastName, party.tin, params.role
        )

        if(params.offset){
            offset = Math.min(params.offset ? params.int('offset') : 0, result.size())
        }
        //Record Count - if sql query is used
        def recordCount = offset + params.max
        if(recordCount >= result.size()){
            recordCount = result.size()
        }
        
        [partyInstanceList: result.subList(offset, recordCount), partyInstanceTotal: result.size(), partyInstance: party, recordCount : recordCount]
    }

    def create = {
        def employeeData = new EmployeeData()
        return [payeeData : employeeData]
    }

    def save = {EmployeeData data ->

        def partyInstance = new Party()
        def personInstance = new Person(params)
        def partyRole = new PartyRole(params)

        bindData(data, params)

        data.status = 'Active'
        data.department = 'Administration'
        data.position = 'Clerk'

        data.fullName = data.firstName + ' ' + data.middleName + ' ' + data.lastName
        if (data.fullName.trim().size() <= 0) {
            data.fullName = 'n/a'
        } /* To remove the Employee Full Name validation whenever no names was entered. */

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

            partyRole.party = Party.get(partyInstance.id)
            partyRole.fromDate = new Date()
            partyRole.status = 'Active'
            partyRole.role = data.role
            partyRole.save(flush:true)

            appUtilityService.createContactEntries(data, Party.get(partyInstance.id))

            flash.message = "${message(code: 'default.created.message', args: [message(code: 'employee.label', default: 'Employee'), partyInstance.name])}"
            redirect(action: "show", id: partyInstance.id)

        } else {
            render(view: "create", model : [payeeData: data])
            return
        }
    }

    def show = {

        def partyInstance = Party.get(params.id)

        def payeeData = appUtilityService.preparePayeeData(partyInstance)

        if (!payeeData) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Payee'), params.name])}"
            redirect(action: "list")
        }
        else {
            [payeeData: payeeData]
        }
    }

    def edit = {

        def partyInstance = Party.get(params.id)

        def payeeData = appUtilityService.preparePayeeData(partyInstance)

        if (!payeeData) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Payee'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [payeeData: payeeData]
        }
    }

    def update = { EmployeeData data ->

        bindData(data, params)

        data.department = 'Administration'
        data.position = 'Clerk'

        data.fullName = data.firstName + ' ' + data.middleName + ' ' + data.lastName
        if (data.fullName.trim().size() <= 0) {
            data.fullName = 'n/a'
        } /* To remove the Employee Full Name validation whenever no names was entered. */

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

            def partyRole = PartyRole.findByParty(partyInstance)
            partyRole.role = data.role
            if(data.status == 'Inactive'){
                if (partyRole != null) {
                    partyRole.status = 'Inactive'
                    partyRole.thruDate = new Date()
                }
            }
            partyRole.save(flush:true)

            appUtilityService.updateContactEntries(data)

            flash.message = "${message(code: 'default.updated.message', args: [message(code: 'party.label', default: 'Payee'), partyInstance.name])}"
            redirect(action: "show", id: data.partyId)

        } else {
            render(view: "edit", model : [payeeData : data])
            return 
        }
    }

    def delete = {
        def partyInstance = Party.get(params.id)
        if (partyInstance) {
            try {
                partyInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'party.label', default: 'Party'), params.name])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'party.label', default: 'Party'), params.name])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), params.name])}"
            redirect(action: "list")
        }
    }
}
