package com.app

class ApprovalController {

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
        def approvalInstance = new Approval()

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [approvalInstance : approvalInstance, approvalInstanceList: Approval.list(params), approvalInstanceTotal: Approval.count()]
    }

    def create = {
        def approvalInstance = new Approval()
        approvalInstance.properties = params
        return [approvalInstance: approvalInstance]
    }

    def save = {
        def approvalInstance = new Approval(params)
        if (approvalInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'approval.label', default: 'Approval'), approvalInstance.id])}"
            redirect(action: "show", id: approvalInstance.id)
        }
        else {
            render(view: "create", model: [approvalInstance: approvalInstance])
        }
    }

    def show = {
        def approvalInstance = Approval.get(params.id)
        if (!approvalInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'approval.label', default: 'Approval'), params.id])}"
            redirect(action: "list")
        }
        else {
            [approvalInstance: approvalInstance]
        }
    }

    def edit = {
        def approvalInstance = Approval.get(params.id)
        if (!approvalInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'approval.label', default: 'Approval'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [approvalInstance: approvalInstance]
        }
    }

    def update = {
        def approvalInstance = Approval.get(params.id)
        if (approvalInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (approvalInstance.version > version) {
                    
                    approvalInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'approval.label', default: 'Approval')] as Object[], "Another user has updated this Approval while you were editing")
                    render(view: "edit", model: [approvalInstance: approvalInstance])
                    return
                }
            }
            approvalInstance.properties = params
            if (!approvalInstance.hasErrors() && approvalInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'approval.label', default: 'Approval'), approvalInstance.id])}"
                redirect(action: "show", id: approvalInstance.id)
            }
            else {
                render(view: "edit", model: [approvalInstance: approvalInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'approval.label', default: 'Approval'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def approvalInstance = Approval.get(params.id)
        if (approvalInstance) {
            try {
                approvalInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'approval.label', default: 'Approval'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'approval.label', default: 'Approval'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'approval.label', default: 'Approval'), params.id])}"
            redirect(action: "list")
        }
    }
}
