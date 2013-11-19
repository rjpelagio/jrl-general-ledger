package com.app

class PartyController {

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
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        def offset = 0
        def party = new Party()
        party.properties = params.properties;
        
        def result = appSearchService.getParty(
            party.name, party.firstName, party.middleName, party.lastName, party.tin
        )

        if(params.offset){
            offset = Math.min(params.offset ? params.int('offset') : 0, result.size())
        }
        //Record Count - if sql query is used
        def recordCount = offset + params.max
        if(recordCount >= result.size()){
            recordCount = result.size()
        }
        println 'Results' + result
        
        [partyInstanceList: result.subList(offset, recordCount), partyInstanceTotal: result.size(), partyInstance: party, recordCount : recordCount]
    }

    def create = {
        def partyInstance = new Party()
        partyInstance.properties = params
        return [partyInstance: partyInstance]
    }

    def save = {
        def partyInstance = new Party(params)
        if (partyInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'party.label', default: 'Party'), partyInstance.name])}"
            redirect(action: "show", id: partyInstance.id)
        }
        else {
            render(view: "create", model: [partyInstance: partyInstance])
        }
    }

    def show = {
        def partyInstance = Party.get(params.id)
        if (!partyInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), params.name])}"
            redirect(action: "list")
        }
        else {
            [partyInstance: partyInstance]
        }
    }

    def edit = {
        def partyInstance = Party.get(params.id)
        if (!partyInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), params.name])}"
            redirect(action: "list")
        }
        else {
            return [partyInstance: partyInstance]
        }
    }

    def update = {
        def partyInstance = Party.get(params.id)
        if (partyInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (partyInstance.version > version) {
                    
                    partyInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'party.label', default: 'Payee')] as Object[], "Another user has updated this Party while you were editing")
                    render(view: "edit", model: [partyInstance: partyInstance])
                    return
                }
            }
            partyInstance.properties = params
            if (!partyInstance.hasErrors() && partyInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'party.label', default: 'Payee'), partyInstance.name])}"
                redirect(action: "show", id: partyInstance.id)
            }
            else {
                render(view: "edit", model: [partyInstance: partyInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), params.name])}"
            redirect(action: "list")
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
