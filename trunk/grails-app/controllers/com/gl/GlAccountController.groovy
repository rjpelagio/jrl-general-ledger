package com.gl

import com.gl.GlAccountOrganization
import com.app.AppOrganization
import groovy.sql.Sql

class GlAccountController {
    def glSearchService;
    def glAccountService;

    def dataSource
    
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
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        def offset = 0
        def gl = new GlAccount();

        gl.properties = params.properties;
        def result = glSearchService.getGlAccounts(
            gl.glAccount, gl.description, gl.glAccountType, gl.parentGlAccount
        );
        if(params.offset){
            offset = Math.min(params.offset ? params.int('offset') : 0, result.size())
        }
        def toIndex = offset + params.max
        if(toIndex>=result.size()){
            toIndex=result.size()
        }
        [glAccountInstanceList: result.subList(offset, toIndex), glAccountInstanceTotal: result.size(), offset: (toIndex)]
    }

    def create = {
        def glAccountInstance = new GlAccount()
        
        glAccountInstance.properties = params
        return [glAccountInstance: glAccountInstance, organizationInstance: AppOrganization.list()]
    }

    def save = {
        def glAccountInstance = new GlAccount(params)
        def organization = params.organization
        
        if (glAccountInstance.save(flush: true)) {
            flash.message = "${message(code: 'glAccount.created', args: [message(code: 'glAccount.label', default: 'GlAccount'), glAccountInstance.id])}"
            glAccountService.insertAccount(
                glAccountInstance,
                organization
            )
            redirect(action: "show", id: glAccountInstance.id)
        }
        else {
            render(view: "create", model: [glAccountInstance: glAccountInstance, organizationInstance: AppOrganization.list()])
        }
    }

    def show = {
        def glAccountInstance = GlAccount.get(params.id)
        def glAccountId = glAccountInstance.id
        
        def organizationInstance = GlAccountOrganization.executeQuery("\
            FROM GlAccountOrganization glo\
            WHERE glo.glAccount = ?", [glAccountInstance])

        if (!glAccountInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccount.label', default: 'GlAccount'), params.id])}"
            redirect(action: "list")
        }
        else {
            [glAccountInstance: glAccountInstance, organizationInstance: organizationInstance]
        }
    }

    def edit = {
        def db = new Sql(dataSource)
        def glAccountInstance = GlAccount.get(params.id)
        //def glAccountOrganizationInstance = GlAccountOrganization.executeQuery("\
        //    FROM GlAccountOrganization glo\
        //    WHERE glo.glAccount = ?", [glAccountInstance])

        def glAccountOrganizationInstance = db.rows("SELECT * \
            FROM\
                (SELECT * \
                FROM app_organization\
                LEFT JOIN\
                (SELECT organization_id\
                FROM gl_account_organization\
                WHERE gl_account_id='3') as gl_account\
                ON app_organization.id=gl_account.organization_id) as organization\
            LEFT JOIN\
                (SELECT DISTINCT(organization_id) as trans_organization_id\
                FROM gl_accounting_transaction\
                WHERE id IN\
                    (SELECT gl_accounting_transaction_id\
                    FROM gl_accounting_transaction_details\
                    WHERE gl_account_id='"+ glAccountInstance.id +"')) as trans\
            ON organization.organization_id=trans.trans_organization_id")

        println glAccountOrganizationInstance
        
        if (!glAccountInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccount.label', default: 'GlAccount'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [glAccountInstance: glAccountInstance, organizationInstance: AppOrganization.list(), glAccountOrganizationInstance: glAccountOrganizationInstance]
        }
    }

    def update = {
        def db = new Sql(dataSource)
        def glAccountInstance = GlAccount.get(params.id)
        def organization = params.organization
        def organizationList = AppOrganization.list()

        println "Org List: " + organization

        def organizationInstance = GlAccountOrganization.executeQuery("\
            FROM GlAccountOrganization glo\
            WHERE glo.glAccount = ?", [glAccountInstance])

        def glAccountOrganizationInstance = GlAccountOrganization.executeQuery("\
            FROM GlAccountOrganization glo\
            WHERE glo.glAccount = ?", [glAccountInstance])


        if (glAccountInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (glAccountInstance.version > version) {
                    
                    glAccountInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'glAccount.label', default: 'GlAccount')] as Object[], "Another user has updated this GlAccount while you were editing")
                    render(view: "edit", model: [glAccountInstance: glAccountInstance])
                    return
                }
            }
            glAccountInstance.properties = params
            if (!glAccountInstance.hasErrors() && glAccountInstance.save(flush: true)) {
                flash.message = "${message(code: 'glAccount.updated', args: [message(code: 'glAccount.label', default: 'GlAccount'), glAccountInstance.id])}"
                glAccountService.updateAccount(
                    glAccountInstance,
                    organization,
                    glAccountOrganizationInstance
                )
                redirect(action: "show", id: glAccountInstance.id)
            }
            else {
                render(view: "edit", model: [glAccountInstance: glAccountInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccount.label', default: 'GlAccount'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def glAccountInstance = GlAccount.get(params.id)
        if (glAccountInstance) {
            try {
                glAccountInstance.delete(flush: true)
                flash.message = "${message(code: 'glAccount.deleted', args: [message(code: 'glAccount.label', default: 'GlAccount'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'glAccount.label', default: 'GlAccount'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccount.label', default: 'GlAccount'), params.id])}"
            redirect(action: "list")
        }
    }
}
