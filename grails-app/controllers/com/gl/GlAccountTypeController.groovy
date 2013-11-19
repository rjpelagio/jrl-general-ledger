package com.gl

class GlAccountTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def glSearchService
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
        def glAccountTypeInstance = new GlAccountType()
        def offset = 0
        if(params.offset==null){
            offset = 0 + params.int('max')
        }
        else{
            offset = params.int('offset') + params.int('max')
        }
        if(offset > GlAccountType.count()){
            offset = GlAccountType.count()
        }
        glAccountTypeInstance.properties = params.properties
        //glAccountTypeInstance.properties = params
        [glAccountTypeInstanceList: GlAccountType.list(params), glAccountTypeInstanceTotal: GlAccountType.count(), recordCount : offset, glAccountTypeInstance: glAccountTypeInstance]
    }

    def create = {
        def glAccountTypeInstance = new GlAccountType()
        glAccountTypeInstance.properties = params
        return [glAccountTypeInstance: glAccountTypeInstance]
    }

    def save = {
        def glAccountTypeInstance = new GlAccountType(params)
        if (glAccountTypeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'glAccountType.label', default: 'GlAccountType'), glAccountTypeInstance.glAccountType])}"
            redirect(action: "show", id: glAccountTypeInstance.id)
        }
        else {
            render(view: "create", model: [glAccountTypeInstance: glAccountTypeInstance])
        }
    }

    def show = {
        def glAccountTypeInstance = GlAccountType.get(params.id)
        if (!glAccountTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountType.label', default: 'GlAccountType'), glAccountTypeInstance.glAccountType])}"
            redirect(action: "list")
        }
        else {
            [glAccountTypeInstance: glAccountTypeInstance]
        }
    }

    def edit = {
        def glAccountTypeInstance = GlAccountType.get(params.id)
        if (!glAccountTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountType.label', default: 'GlAccountType'), glAccountTypeInstance.glAccountType])}"
            redirect(action: "list")
        }
        else {
            return [glAccountTypeInstance: glAccountTypeInstance]
        }
    }

    def update = {
        def glAccountTypeInstance = GlAccountType.get(params.id)
        if (glAccountTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (glAccountTypeInstance.version > version) {
                    
                    glAccountTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'glAccountType.label', default: 'GlAccountType')] as Object[], "Another user has updated this GlAccountType while you were editing")
                    render(view: "edit", model: [glAccountTypeInstance: glAccountTypeInstance])
                    return
                }
            }
            glAccountTypeInstance.properties = params
            if (!glAccountTypeInstance.hasErrors() && glAccountTypeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'glAccountType.label', default: 'GlAccountType'), glAccountTypeInstance.glAccountType])}"
                redirect(action: "show", id: glAccountTypeInstance.id)
            }
            else {
                render(view: "edit", model: [glAccountTypeInstance: glAccountTypeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountType.label', default: 'GlAccountType'), glAccountTypeInstance.glAccountType])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def glAccountTypeInstance = GlAccountType.get(params.id)
        if (glAccountTypeInstance) {
            try {
                glAccountTypeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'glAccountType.label', default: 'GlAccountType'), glAccountTypeInstance.glAccountType])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'glAccountType.label', default: 'GlAccountType'), glAccountTypeInstance.glAccountType])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountType.label', default: 'GlAccountType'), glAccountTypeInstance.glAccountType])}"
            redirect(action: "list")
        }
    }
}
