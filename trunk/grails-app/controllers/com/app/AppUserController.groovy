package com.app

import com.gl.*
import groovy.sql.Sql

class AppUserController {
    
    def appSearchService;

    def dataSource

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", savePassword: "POST"]
    
    def beforeInterceptor = [action:this.&auth,
        except:['login', 'logout', 'authenticate']]

    def auth() {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }
    }
    
    def logout = {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }
        else{
            flash.message = "Goodbye ${session.user.username}"
            session.user = null
            redirect(uri:"/")
        }
    }
    
    def authenticate = {
        if(!params.username) {
            redirect(uri:"/")
            return false
        }
        else{
            String encryptedPassword = params.password;
            encryptedPassword = encryptedPassword.encodeAsSHA();
            def user = AppUser.findByUsername(params.username)
            if (!user) {
                flash.message =
                    "Sorry, username ${params.username} is not valid."
                redirect(uri:"/")
            } else {
                def party = Party.find(user.party)
                def employee = Employee.findByParty(party)
                def organization = AppOrganization.get(params.organization.id);
                if (user.password == params.password.encodeAsSHA()){
                    user.password = params.password
                    session.user = user
                    session.organization = organization
                    session.employee = employee
                    user.lastLogin = new Date();
                    user.save()
                    flash.message = "Hello ${party.name}!"
                    redirect(uri:"/")
                } else {
                    flash.message =
                    "Sorry, ${params.username}. Password is incorrect."
                    redirect(uri:"/")
                }
            }
        }
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        def db = new Sql(dataSource)
        def user = new AppUser();
        user.properties = params.properties;
        def appUserInstance = new AppUser();
        appUserInstance.properties = params.properties;
        def result = appSearchService.getUsers(
            user.username, user.role, user.party
        )

        //def employeeDropDown = Party.executeQuery("\
        //    FROM Party party\
        //    WHERE party.id IN (SELECT party FROM AppUser)"
        //)

        def employeeDropDown = db.rows("SELECT *\
            FROM Party\
            WHERE party_id NOT IN (SELECT party_id FROM app_user)\
            AND party_id IN (SELECT party_id FROM employee)"
        )
        
        //println "drop down values: " + employeeDropDown

        def offset = 0 + params.int('max')
        if(params.offset){
             offset = params.int('offset')+ params.int('max')
        }

        if(offset>result.size()){
            offset = result.size()
        }
        
        [appUserInstanceList: result, appUserInstanceTotal: result.size(), appUserInstance: appUserInstance, employeeDropDown : employeeDropDown, recordCount : offset]
    }
    
    def create = {
        def appUserInstance = new AppUser()
        def db = new Sql(dataSource)
        appUserInstance.properties = params

        def employeeDropDown = db.rows("SELECT *\
            FROM Party\
            WHERE party_id NOT IN (SELECT party_id FROM app_user)\
            AND party_id IN (SELECT party_id FROM employee)"
        )
        return [appUserInstance: appUserInstance, employeeDropDown: employeeDropDown]
    }

    def save = {
        def appUserInstance = new AppUser(params)
        if (appUserInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'appUser.label', default: 'AppUser'), appUserInstance.username])}"
            redirect(action: "show", id: appUserInstance.id)
        }
        else {
            render(view: "create", model: [appUserInstance: appUserInstance])
        }
    }

    def show = {
        def appUserInstance = AppUser.get(params.id)
        if (!appUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appUser.label', default: 'AppUser'), params.username])}"
            redirect(action: "list")
        }
        else {
            [appUserInstance: appUserInstance]
        }
    }

    def edit = {
        def appUserInstance = AppUser.get(params.id)
        def db = new Sql(dataSource)
        def employeeDropDown = db.rows("SELECT *\
            FROM Party\
            WHERE party_id IN (SELECT party_id FROM employee)\
            AND (party_id NOT IN (SELECT party_id FROM app_user)\
            OR party_id = "+ appUserInstance.party.id +")"
        )
        if (!appUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appUser.label', default: 'AppUser'), params.username])}"
            redirect(action: "list")
        }
        else {
            return [appUserInstance: appUserInstance, employeeDropDown: employeeDropDown]
        }
    }

    def update = {
        def appUserInstance = AppUser.get(params.id)
        if (appUserInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (appUserInstance.version > version) {
                    
                    appUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'appUser.label', default: 'AppUser')] as Object[], "Another user has updated this AppUser while you were editing")
                    render(view: "edit", model: [appUserInstance: appUserInstance])
                    return
                }
            }
            appUserInstance.properties = params
            if (!appUserInstance.hasErrors() && appUserInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'appUser.label', default: 'AppUser'), appUserInstance.username])}"
                redirect(action: "show", id: appUserInstance.id)
            }
            else {
                render(view: "edit", model: [appUserInstance: appUserInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appUser.label', default: 'AppUser'), params.username])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def appUserInstance = AppUser.get(params.id)
        if (appUserInstance) {
            try {
                appUserInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'appUser.label', default: 'AppUser'), params.username])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'appUser.label', default: 'AppUser'), params.username])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appUser.label', default: 'AppUser'), params.username])}"
            redirect(action: "list")
        }
    }

    def changePassword = {
        println "Change Password"
        def appUserInstance = AppUser.get(session.user.id)
        if (!appUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appUser.label', default: 'AppUser'), params.username])}"
            redirect(action: "list")
        }
        else {
            println "Display password changing"
            return [appUserInstance: appUserInstance]
        }
    }

    def savePassword = {
        println "Params: " + params
        def appUserInstance = AppUser.get(params.id)
        if (appUserInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (appUserInstance.version > version) {

                    appUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'appUser.label', default: 'AppUser')] as Object[], "Another user has updated this AppUser while you were editing")
                    render(view: "changePassword", model: [appUserInstance: appUserInstance])
                    return
                }
            }
            def password = appUserInstance.password
            String oldpassword = params.oldpassword
            String newpassword = params.newpassword
            String confirmpassword = params.confirmpassword

            appUserInstance.properties = params
            
            if (!appUserInstance.hasErrors() && appUserInstance.save(flush: true)) {
                flash.message = "${message(code: 'appUser.password.updated')}"
                redirect(uri:"/")
            }
            else {
                render(view: "changePassword", model: [appUserInstance: appUserInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appUser.label', default: 'AppUser'), params.username])}"
            redirect(uri:"/")
        }
    }
}
