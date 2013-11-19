package com.gl

class AcctgPreferencesController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
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
        [acctgPreferencesInstanceList: AcctgPreferences.list(params), acctgPreferencesInstanceTotal: AcctgPreferences.count()]
    }

    def create = {
        def acctgPreferencesInstance = new AcctgPreferences()
        acctgPreferencesInstance.properties = params
        return [acctgPreferencesInstance: acctgPreferencesInstance]
    }

    def save = {
        def acctgPreferencesInstance = new AcctgPreferences(params)
        if (acctgPreferencesInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'acctgPreferences.label', default: 'AcctgPreferences'), acctgPreferencesInstance.id])}"
            redirect(action: "show", id: acctgPreferencesInstance.id)
        }
        else {
            render(view: "create", model: [acctgPreferencesInstance: acctgPreferencesInstance])
        }
    }

    def show = {
        def acctgPreferencesInstance = AcctgPreferences.get(params.id)
        if (!acctgPreferencesInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'acctgPreferences.label', default: 'AcctgPreferences'), params.id])}"
            redirect(action: "list")
        }
        else {
            [acctgPreferencesInstance: acctgPreferencesInstance]
        }
    }

    def edit = {
        def acctgPreferencesInstance = AcctgPreferences.get(params.id)
        if (!acctgPreferencesInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'acctgPreferences.label', default: 'AcctgPreferences'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [acctgPreferencesInstance: acctgPreferencesInstance]
        }
    }

    def update = {
        def acctgPreferencesInstance = AcctgPreferences.get(params.id)
        if (acctgPreferencesInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (acctgPreferencesInstance.version > version) {
                    
                    acctgPreferencesInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'acctgPreferences.label', default: 'AcctgPreferences')] as Object[], "Another user has updated this AcctgPreferences while you were editing")
                    render(view: "edit", model: [acctgPreferencesInstance: acctgPreferencesInstance])
                    return
                }
            }
            acctgPreferencesInstance.properties = params
            if (!acctgPreferencesInstance.hasErrors() && acctgPreferencesInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'acctgPreferences.label', default: 'AcctgPreferences'), acctgPreferencesInstance.id])}"
                redirect(action: "show", id: acctgPreferencesInstance.id)
            }
            else {
                render(view: "edit", model: [acctgPreferencesInstance: acctgPreferencesInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'acctgPreferences.label', default: 'AcctgPreferences'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def acctgPreferencesInstance = AcctgPreferences.get(params.id)
        if (acctgPreferencesInstance) {
            try {
                acctgPreferencesInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'acctgPreferences.label', default: 'AcctgPreferences'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'acctgPreferences.label', default: 'AcctgPreferences'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'acctgPreferences.label', default: 'AcctgPreferences'), params.id])}"
            redirect(action: "list")
        }
    }
}
