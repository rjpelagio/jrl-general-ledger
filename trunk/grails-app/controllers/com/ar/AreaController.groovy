package com.ar

class AreaController {

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
        [areaInstanceList: Area.list(params), areaInstanceTotal: Area.count()]
    }

    def create = {
        def areaInstance = new Area()
        areaInstance.properties = params
        return [areaInstance: areaInstance]
    }

    def save = {
        def areaInstance = new Area(params)
        if (areaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'area.label', default: 'Area'), areaInstance.id])}"
            redirect(action: "show", id: areaInstance.id)
        }
        else {
            render(view: "create", model: [areaInstance: areaInstance])
        }
    }

    def show = {
        def areaInstance = Area.get(params.id)
        if (!areaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'area.label', default: 'Area'), params.id])}"
            redirect(action: "list")
        }
        else {
            [areaInstance: areaInstance]
        }
    }

    def edit = {
        def areaInstance = Area.get(params.id)
        if (!areaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'area.label', default: 'Area'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [areaInstance: areaInstance]
        }
    }

    def update = {
        def areaInstance = Area.get(params.id)
        if (areaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (areaInstance.version > version) {
                    
                    areaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'area.label', default: 'Area')] as Object[], "Another user has updated this Area while you were editing")
                    render(view: "edit", model: [areaInstance: areaInstance])
                    return
                }
            }
            areaInstance.properties = params
            if (!areaInstance.hasErrors() && areaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'area.label', default: 'Area'), areaInstance.id])}"
                redirect(action: "show", id: areaInstance.id)
            }
            else {
                render(view: "edit", model: [areaInstance: areaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'area.label', default: 'Area'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def areaInstance = Area.get(params.id)
        if (areaInstance) {
            try {
                areaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'area.label', default: 'Area'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'area.label', default: 'Area'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'area.label', default: 'Area'), params.id])}"
            redirect(action: "list")
        }
    }
}
