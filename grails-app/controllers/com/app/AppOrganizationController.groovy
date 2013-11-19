package com.app

class AppOrganizationController {

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
        def appOrganizationInstance = new AppOrganization()
        appOrganizationInstance.properties = params
        [appOrganizationInstanceList: AppOrganization.list(params), appOrganizationInstanceTotal: AppOrganization.count(), appOrganizationInstance: appOrganizationInstance]
    }

    def create = {
        def appOrganizationInstance = new AppOrganization()
        appOrganizationInstance.properties = params
        return [appOrganizationInstance: appOrganizationInstance]
    }

    def save = {
        def appOrganizationInstance = new AppOrganization(params)
        if (appOrganizationInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'appOrganization.label', default: 'AppOrganization'), appOrganizationInstance.id])}"
            redirect(action: "show", id: appOrganizationInstance.id)
        }
        else {
            render(view: "create", model: [appOrganizationInstance: appOrganizationInstance])
        }
    }

    def show = {
        def appOrganizationInstance = AppOrganization.get(params.id)
        if (!appOrganizationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appOrganization.label', default: 'AppOrganization'), params.id])}"
            redirect(action: "list")
        }
        else {
            [appOrganizationInstance: appOrganizationInstance]
        }
    }

    def edit = {
        def appOrganizationInstance = AppOrganization.get(params.id)
        if (!appOrganizationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appOrganization.label', default: 'AppOrganization'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [appOrganizationInstance: appOrganizationInstance]
        }
    }

    def update = {
        def appOrganizationInstance = AppOrganization.get(params.id)
        if (appOrganizationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (appOrganizationInstance.version > version) {
                    
                    appOrganizationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'appOrganization.label', default: 'AppOrganization')] as Object[], "Another user has updated this AppOrganization while you were editing")
                    render(view: "edit", model: [appOrganizationInstance: appOrganizationInstance])
                    return
                }
            }
            appOrganizationInstance.properties = params
            if (!appOrganizationInstance.hasErrors() && appOrganizationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'appOrganization.label', default: 'AppOrganization'), appOrganizationInstance.id])}"
                redirect(action: "show", id: appOrganizationInstance.id)
            }
            else {
                render(view: "edit", model: [appOrganizationInstance: appOrganizationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appOrganization.label', default: 'AppOrganization'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def appOrganizationInstance = AppOrganization.get(params.id)
        if (appOrganizationInstance) {
            try {
                appOrganizationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'appOrganization.label', default: 'AppOrganization'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'appOrganization.label', default: 'AppOrganization'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appOrganization.label', default: 'AppOrganization'), params.id])}"
            redirect(action: "list")
        }
    }
}
