package com.gl

class PeriodTypeController {

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
        def offset = 0
        if(params.offset){
            offset = params.int('offset')
        }
        offset = offset + params.int('max')
        if(offset>PeriodType.count()){
            offset = PeriodType.count()
        }
        [periodTypeInstanceList: PeriodType.list(params), periodTypeInstanceTotal: PeriodType.count(), recordCount : offset]
    }

    def create = {
        def periodTypeInstance = new PeriodType()
        periodTypeInstance.properties = params
        return [periodTypeInstance: periodTypeInstance]
    }

    def save = {
        def periodTypeInstance = new PeriodType(params)
        if (periodTypeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'periodType.label', default: 'PeriodType'), periodTypeInstance.id])}"
            redirect(action: "show", id: periodTypeInstance.id)
        }
        else {
            render(view: "create", model: [periodTypeInstance: periodTypeInstance])
        }
    }

    def show = {
        def periodTypeInstance = PeriodType.get(params.id)
        if (!periodTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'periodType.label', default: 'PeriodType'), params.id])}"
            redirect(action: "list")
        }
        else {
            [periodTypeInstance: periodTypeInstance]
        }
    }

    def edit = {
        def periodTypeInstance = PeriodType.get(params.id)
        if (!periodTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'periodType.label', default: 'PeriodType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [periodTypeInstance: periodTypeInstance]
        }
    }

    def update = {
        def periodTypeInstance = PeriodType.get(params.id)
        if (periodTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (periodTypeInstance.version > version) {
                    
                    periodTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'periodType.label', default: 'PeriodType')] as Object[], "Another user has updated this PeriodType while you were editing")
                    render(view: "edit", model: [periodTypeInstance: periodTypeInstance])
                    return
                }
            }
            periodTypeInstance.properties = params
            if (!periodTypeInstance.hasErrors() && periodTypeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'periodType.label', default: 'PeriodType'), periodTypeInstance.id])}"
                redirect(action: "show", id: periodTypeInstance.id)
            }
            else {
                render(view: "edit", model: [periodTypeInstance: periodTypeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'periodType.label', default: 'PeriodType'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def periodTypeInstance = PeriodType.get(params.id)
        if (periodTypeInstance) {
            try {
                periodTypeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'periodType.label', default: 'PeriodType'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'periodType.label', default: 'PeriodType'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'periodType.label', default: 'PeriodType'), params.id])}"
            redirect(action: "list")
        }
    }
}
