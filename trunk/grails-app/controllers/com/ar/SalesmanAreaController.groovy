package com.ar

class SalesmanAreaController {

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
        [salesmanAreaInstanceList: SalesmanArea.list(params), salesmanAreaInstanceTotal: SalesmanArea.count()]
    }

    def create = {
        def salesmanAreaInstance = new SalesmanArea()
        salesmanAreaInstance.properties = params
        return [salesmanAreaInstance: salesmanAreaInstance]
    }

    def save = {
        def salesmanAreaInstance = new SalesmanArea(params)
        if (salesmanAreaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'salesmanArea.label', default: 'SalesmanArea'), salesmanAreaInstance.id])}"
            redirect(action: "show", id: salesmanAreaInstance.id)
        }
        else {
            render(view: "create", model: [salesmanAreaInstance: salesmanAreaInstance])
        }
    }

    def show = {
        def salesmanAreaInstance = SalesmanArea.get(params.id)
        if (!salesmanAreaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'salesmanArea.label', default: 'SalesmanArea'), params.id])}"
            redirect(action: "list")
        }
        else {
            [salesmanAreaInstance: salesmanAreaInstance]
        }
    }

    def edit = {
        def salesmanAreaInstance = SalesmanArea.get(params.id)
        if (!salesmanAreaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'salesmanArea.label', default: 'SalesmanArea'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [salesmanAreaInstance: salesmanAreaInstance]
        }
    }

    def update = {
        def salesmanAreaInstance = SalesmanArea.get(params.id)
        if (salesmanAreaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (salesmanAreaInstance.version > version) {
                    
                    salesmanAreaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'salesmanArea.label', default: 'SalesmanArea')] as Object[], "Another user has updated this SalesmanArea while you were editing")
                    render(view: "edit", model: [salesmanAreaInstance: salesmanAreaInstance])
                    return
                }
            }
            salesmanAreaInstance.properties = params
            if (!salesmanAreaInstance.hasErrors() && salesmanAreaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'salesmanArea.label', default: 'SalesmanArea'), salesmanAreaInstance.id])}"
                redirect(action: "show", id: salesmanAreaInstance.id)
            }
            else {
                render(view: "edit", model: [salesmanAreaInstance: salesmanAreaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'salesmanArea.label', default: 'SalesmanArea'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def salesmanAreaInstance = SalesmanArea.get(params.id)
        if (salesmanAreaInstance) {
            try {
                salesmanAreaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'salesmanArea.label', default: 'SalesmanArea'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'salesmanArea.label', default: 'SalesmanArea'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'salesmanArea.label', default: 'SalesmanArea'), params.id])}"
            redirect(action: "list")
        }
    }
}
