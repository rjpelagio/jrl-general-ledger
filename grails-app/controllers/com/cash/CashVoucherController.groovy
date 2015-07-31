package com.cash

class CashVoucherController {

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

        def cashVoucherInstance = new CashVoucher()

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cashVoucherInstanceList: CashVoucher.list(params), 
            cashVoucherInstanceTotal: CashVoucher.count(),
            cashVoucherInstance : cashVoucherInstance]
    }

    def create = {
        def cashVoucherInstance = new CashVoucher()
        cashVoucherInstance.properties = params
        return [cashVoucherInstance: cashVoucherInstance]
    }

    def save = {
        def cashVoucherInstance = new CashVoucher(params)
        if (cashVoucherInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), cashVoucherInstance.id])}"
            redirect(action: "show", id: cashVoucherInstance.id)
        }
        else {
            render(view: "create", model: [cashVoucherInstance: cashVoucherInstance])
        }
    }

    def show = {
        def cashVoucherInstance = CashVoucher.get(params.id)
        if (!cashVoucherInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
            redirect(action: "list")
        }
        else {
            [cashVoucherInstance: cashVoucherInstance]
        }
    }

    def edit = {
        def cashVoucherInstance = CashVoucher.get(params.id)
        if (!cashVoucherInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [cashVoucherInstance: cashVoucherInstance]
        }
    }

    def update = {
        def cashVoucherInstance = CashVoucher.get(params.id)
        if (cashVoucherInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (cashVoucherInstance.version > version) {
                    
                    cashVoucherInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'cashVoucher.label', default: 'CashVoucher')] as Object[], "Another user has updated this CashVoucher while you were editing")
                    render(view: "edit", model: [cashVoucherInstance: cashVoucherInstance])
                    return
                }
            }
            cashVoucherInstance.properties = params
            if (!cashVoucherInstance.hasErrors() && cashVoucherInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), cashVoucherInstance.id])}"
                redirect(action: "show", id: cashVoucherInstance.id)
            }
            else {
                render(view: "edit", model: [cashVoucherInstance: cashVoucherInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def cashVoucherInstance = CashVoucher.get(params.id)
        if (cashVoucherInstance) {
            try {
                cashVoucherInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
            redirect(action: "list")
        }
    }
}
