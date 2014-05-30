package com.ar

class SalesmanController {

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
        [salesmanInstanceList: Salesman.list(params), salesmanInstanceTotal: Salesman.count()]
    }

    def create = {
        def salesmanInstance = new Salesman()
        salesmanInstance.properties = params
        return [salesmanInstance: salesmanInstance]
    }

    def save = {
        def salesmanInstance = new Salesman(params)
        if (salesmanInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'salesman.label', default: 'Salesman'), salesmanInstance.id])}"
            redirect(action: "show", id: salesmanInstance.id)
        }
        else {
            render(view: "create", model: [salesmanInstance: salesmanInstance])
        }
    }

    def show = {
        def salesmanInstance = Salesman.get(params.id)
        if (!salesmanInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'salesman.label', default: 'Salesman'), params.id])}"
            redirect(action: "list")
        }
        else {
            [salesmanInstance: salesmanInstance]
        }
    }

    def edit = {
        def salesmanInstance = Salesman.get(params.id)
        if (!salesmanInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'salesman.label', default: 'Salesman'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [salesmanInstance: salesmanInstance]
        }
    }

    def update = {
        def salesmanInstance = Salesman.get(params.id)
        if (salesmanInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (salesmanInstance.version > version) {
                    
                    salesmanInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'salesman.label', default: 'Salesman')] as Object[], "Another user has updated this Salesman while you were editing")
                    render(view: "edit", model: [salesmanInstance: salesmanInstance])
                    return
                }
            }
            salesmanInstance.properties = params
            if (!salesmanInstance.hasErrors() && salesmanInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'salesman.label', default: 'Salesman'), salesmanInstance.id])}"
                redirect(action: "show", id: salesmanInstance.id)
            }
            else {
                render(view: "edit", model: [salesmanInstance: salesmanInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'salesman.label', default: 'Salesman'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def salesmanInstance = Salesman.get(params.id)
        if (salesmanInstance) {
            try {
                salesmanInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'salesman.label', default: 'Salesman'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'salesman.label', default: 'Salesman'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'salesman.label', default: 'Salesman'), params.id])}"
            redirect(action: "list")
        }
    }
}
