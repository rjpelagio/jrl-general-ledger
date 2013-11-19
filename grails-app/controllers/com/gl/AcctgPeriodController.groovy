package com.gl

import java.util.Date
import com.app.*

class AcctgPeriodController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def glSearchService;
    
    def beforeInterceptor = [action:this.&auth]

    def auth() {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }
        //def role = AppRole.find(1)
        //if(role!='ADM'){
           // flash.message = "${message(code: 'default.created.message', args: [message(code: 'acctgPeriod.label', default: 'AcctgPeriod'), acctgPeriodInstance.acctgPeriod])}"
            //redirect(uri:"/")
        //}
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def acctgPeriodInstance = new AcctgPeriod()
        def offset = 0
        def year = null
        acctgPeriodInstance.properties = params.properties;

        if(params.status==null){
            acctgPeriodInstance.status = null
        }

        if(params.year){
            if(params.year!='null'){
                year = Integer.parseInt(params.year)
            }
        }

        def result = glSearchService.getAcctgPeriod(
            session.organization, acctgPeriodInstance.periodTypeId, acctgPeriodInstance.acctgPeriodNum, acctgPeriodInstance.status, acctgPeriodInstance.year
        )

        if(params.offset){
            offset = Math.min(params.offset ? params.int('offset') : 0, result.size())
        }
        def toIndex = offset + params.max
        if(toIndex>=result.size()){
            toIndex=result.size()
        }

        [acctgPeriodInstanceList: result.subList(offset, toIndex), acctgPeriodInstanceTotal: result.size(), acctgPeriodInstance: acctgPeriodInstance, offset : toIndex, selectedYear: year]
    }

    def create = {
        def acctgPeriodInstance = new AcctgPeriod()
        acctgPeriodInstance.properties = params
        def year = null
        return [acctgPeriodInstance: acctgPeriodInstance, selectedYear: year]
    }

    def save = {
        def acctgPeriodInstance = new AcctgPeriod(params)
        acctgPeriodInstance.organization = session.organization

        if(params.year){
            acctgPeriodInstance.year = params.year
        }

        if (acctgPeriodInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'acctgPeriod.label', default: 'AcctgPeriod'), acctgPeriodInstance.id])}"
            redirect(action: "show", id: acctgPeriodInstance.id)
        }
        else {
            render(view: "create", model: [acctgPeriodInstance: acctgPeriodInstance], , selectedYear: params.year)
        }
    }

    def show = {
        def acctgPeriodInstance = AcctgPeriod.get(params.id)
        if (!acctgPeriodInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'acctgPeriod.label', default: 'AcctgPeriod'), acctgPeriodInstance.acctgPeriod])}"
            redirect(action: "list")
        }
        else {
            [acctgPeriodInstance: acctgPeriodInstance]
        }
    }

    def edit = {
        def acctgPeriodInstance = AcctgPeriod.get(params.id)
        def year = null
        if(acctgPeriodInstance.year){
                year = Integer.parseInt(acctgPeriodInstance.year)
        }
        if (!acctgPeriodInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'acctgPeriod.label', default: 'AcctgPeriod'), acctgPeriodInstance.acctgPeriod])}"
            redirect(action: "list")
        }
        else {
            return [acctgPeriodInstance: acctgPeriodInstance, selectedYear: year]
        }
    }

    def update = {
        def acctgPeriodInstance = AcctgPeriod.get(params.id)
        if(params.year){
            acctgPeriodInstance.year = params.year
        }
        
        //acctgPeriodInstance.organization = session.organization.id

        println "Params: " + params
        if (acctgPeriodInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (acctgPeriodInstance.version > version) {
                    
                    acctgPeriodInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'acctgPeriod.label', default: 'AcctgPeriod')] as Object[], "Another user has updated this AcctgPeriod while you were editing")
                    render(view: "edit", model: [acctgPeriodInstance: acctgPeriodInstance])
                    return
                }
            }
            acctgPeriodInstance.properties = params
            if (!acctgPeriodInstance.hasErrors() && acctgPeriodInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'acctgPeriod.label', default: 'AcctgPeriod'), acctgPeriodInstance.id])}"
                redirect(action: "show", id: acctgPeriodInstance.id)
            }
            else {
                render(view: "edit", model: [acctgPeriodInstance: acctgPeriodInstance], selectedYear: params.year)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'acctgPeriod.label', default: 'AcctgPeriod'), acctgPeriodInstance.acctgPeriod])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def acctgPeriodInstance = AcctgPeriod.get(params.id)
        if (acctgPeriodInstance) {
            try {
                acctgPeriodInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'acctgPeriod.label', default: 'AcctgPeriod'), acctgPeriodInstance.acctgPeriod])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'acctgPeriod.label', default: 'AcctgPeriod'), acctgPeriodInstance.acctgPeriod])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'acctgPeriod.label', default: 'AcctgPeriod'), acctgPeriodInstance.acctgPeriod])}"
            redirect(action: "list")
        }
    }
}
