package com.ar

class CustomerAreaController {

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
        [customerAreaInstanceList: CustomerArea.list(params), customerAreaInstanceTotal: CustomerArea.count()]
    }

    def create = {
        def customerAreaInstance = new CustomerArea()
        customerAreaInstance.properties = params
        return [customerAreaInstance: customerAreaInstance]
    }

    def save = {
        def customerAreaInstance = new CustomerArea(params)
        if (customerAreaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'customerArea.label', default: 'CustomerArea'), customerAreaInstance.id])}"
            redirect(action: "show", id: customerAreaInstance.id)
        }
        else {
            render(view: "create", model: [customerAreaInstance: customerAreaInstance])
        }
    }

    def show = {
        def customerAreaInstance = CustomerArea.get(params.id)
        if (!customerAreaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerArea.label', default: 'CustomerArea'), params.id])}"
            redirect(action: "list")
        }
        else {
            [customerAreaInstance: customerAreaInstance]
        }
    }

    def edit = {
        def customerAreaInstance = CustomerArea.get(params.id)
        if (!customerAreaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerArea.label', default: 'CustomerArea'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [customerAreaInstance: customerAreaInstance]
        }
    }

    def update = {
        def customerAreaInstance = CustomerArea.get(params.id)
        if (customerAreaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (customerAreaInstance.version > version) {
                    
                    customerAreaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'customerArea.label', default: 'CustomerArea')] as Object[], "Another user has updated this CustomerArea while you were editing")
                    render(view: "edit", model: [customerAreaInstance: customerAreaInstance])
                    return
                }
            }
            customerAreaInstance.properties = params
            if (!customerAreaInstance.hasErrors() && customerAreaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'customerArea.label', default: 'CustomerArea'), customerAreaInstance.id])}"
                redirect(action: "show", id: customerAreaInstance.id)
            }
            else {
                render(view: "edit", model: [customerAreaInstance: customerAreaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerArea.label', default: 'CustomerArea'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def customerAreaInstance = CustomerArea.get(params.id)
        if (customerAreaInstance) {
            try {
                customerAreaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'customerArea.label', default: 'CustomerArea'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'customerArea.label', default: 'CustomerArea'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerArea.label', default: 'CustomerArea'), params.id])}"
            redirect(action: "list")
        }
    }
}
