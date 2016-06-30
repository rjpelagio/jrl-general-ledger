package com.cash

import com.app.*
import com.gl.GlAccount

class CashVoucherController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def beforeInterceptor = [action:this.&auth]

    def approvalService;
    def cashVoucherService;
    def cashSearchService;

    private static approvalCheck

    def auth() {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }

        flash.errors = null
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def setup = {


    }

    def list = {

        def disableCreate = 'yes'

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'CASH_ADVANCE')) {
        //if (!approvalCheck) {
            flash.errors = "${message(code : 'approval.notFound')}"
        } else {
            disableCreate = 'no'
        }

        //Convert params.dateCreated to proper date string
        def map = new CashVoucher(params)
        params.dateCreated = map.dateCreated
        params.organization = session.organization.id

        def result = cashSearchService.cashVoucherSearchService(params)
        //def result = CashVoucher.list()
        //println 'Controller Result : ' + result

        params.max = Math.min(params.max ? params.int('max') : 10, 10)
        def offset = 0

        if(params.offset){
            offset = Math.min(params.offset ? params.int('offset') : 0, result.size())
        }
        def toIndex = offset + params.max
        if(toIndex>=result.size()){
            toIndex=result.size()
        }

        def cashVoucherInstance = new CashVoucher()

        [cashVoucherInstanceList: result.subList(offset, toIndex), 
            cashVoucherInstanceTotal: result.size(),
            cashVoucherInstance : cashVoucherInstance,
            offset : toIndex,
            disableCreate : disableCreate]
            
    }

    def create = {

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'CASH_ADVANCE')) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        def setup = CashSetup.get(1)

        def cashVoucherInstance = new CashVoucher()
        cashVoucherInstance.properties = params
        params.total = 0.00
        return [cashVoucherInstance: cashVoucherInstance, setup : setup]

    }

    def save = {

        def now = new Date()

        def cashVoucher = new CashVoucher()
        cashVoucher.status = 'Active'
        processSaveSubmit(cashVoucher, params)

    }

    def submit = {

        if (params.formAction == 'create') {
            def trans = new CashVoucher()
            trans.status = "Submitted"
            processSaveSubmit(trans, params)
        } else if (params.formAction == 'edit') {
            def trans = CashVoucher.get(params.id)
            trans.status = "Submitted"
            processUpdateSubmit(trans, params)
        }
    }

    def show = {
        

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'CASH_ADVANCE')) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        def cashVoucherInstance = CashVoucher.get(params.id)
        if (!cashVoucherInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
            redirect(action: "list")
        }
        else {

            def approvalItems = CashVoucherApproval.findAllByTransaction(cashVoucherInstance, [sort: "sequence", order: "desc"])
            def showButtons =  true

            if (cashVoucherInstance.status == 'Cancelled' || cashVoucherInstance.status == 'Closed') {
                showButtons = false
            } else if (cashVoucherInstance.status == 'Submitted') {
                def approvalSequence = CashVoucherApproval.findByTransactionAndPosition(cashVoucherInstance, session.employee.position)
                if (approvalSequence) {
                    if(approvalSequence.status == 'Submitted') {
                        showButtons = false
                    }
                } else {
                    showButtons = false
                }
            }

            [cashVoucherInstance: cashVoucherInstance, approvalItems : approvalItems, showButtons : showButtons]
        }
    }

    def edit = {

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'CASH_ADVANCE')) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        def trans = CashVoucher.get(params.id)
        if (!trans) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
            redirect(action: "list")
        }
        else {
            def requestedBy = Party.find(trans.requestedBy)
            def approvalItems = CashVoucherApproval.findAllByTransaction(trans, [sort: "sequence", order: "desc"])
            return [cashVoucherInstance: trans, requestedBy : requestedBy, approvalItems : approvalItems]
        }
    }

    def update = {

        def trans = CashVoucher.get(params.id)
        if (trans.status == "Submitted") {
            /* for updating already submitted transactions */
            params.formAction = "updateSubmitted"
        }
        processUpdateSubmit(trans, params)
    }

    def processSaveSubmit (CashVoucher cashVoucher, def params) {

        def now = new Date()

        cashVoucher.approvalStatus = 'Pending Approval'
        cashVoucher.transType = 'CASH_ADVANCE'
        cashVoucher.preparedBy = session.user.party
        cashVoucher.total = params.total.length() > 0 ? Float.parseFloat(params.total) : 0
        cashVoucher.requestedBy = Party.get(params.requestedBy)
        cashVoucher.cashVoucherNumber =  "CA" + now.format("yyMMddHHmmss")
        cashVoucher.description = params.description
        cashVoucher.glAccount = GlAccount.get(params.glAccountId)
        cashVoucher.payee = Party.get(params.payee)
        cashVoucher.change = 0.00
        cashVoucher.dateCreated = now
        cashVoucher.organization = session.organization

        if (cashVoucher.validate()) {
            if (cashVoucher.save(flush: true)) {
                
                if (cashVoucher.status == 'Submitted') {
                    cashVoucherService.validateVoucherApproval(cashVoucher, session, params.remarks, 'cash_advance', params.formAction)
                }

                flash.message = "${message(code: 'default.created.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), cashVoucher.cashVoucherNumber])}"
                redirect(action: "show", id: cashVoucher.id)
            }
            else {
                render(view: "create", model: [cashVoucherInstance: cashVoucher])
            }
        } else {
            render(view: "create", model : [cashVoucherInstance : cashVoucher])
        }
    }


    def processUpdateSubmit (def cashVoucher, def params) {

        cashVoucher.total = params.total.length() > 0 ? Float.parseFloat(params.total) : 0
        cashVoucher.requestedBy = Party.get(params.requestedBy)
        cashVoucher.description = params.description
        cashVoucher.glAccount = GlAccount.get(params.glAccountId)
        cashVoucher.payee = Party.get(params.payee)
        cashVoucher.change = 0.00

        if (cashVoucher.validate()) {
            if (cashVoucher.save(flush: true)) {
                flash.message = "${message(code: 'cashVoucher.updated', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), cashVoucher.cashVoucherNumber])}"
                redirect(action: "show", id: cashVoucher.id)

                if (cashVoucher.status == 'Submitted') {
                    println 'entered'
                    cashVoucherService.validateVoucherApproval(cashVoucher, session, params.remarks, 'cash_advance', params.formAction)
                } 
            }
            else {
                render(view: "edit", model: [cashVoucherInstance: cashVoucher])
            }
        } else {
            render(view: "edit", model : [cashVoucherInstance : cashVoucher])
        }
    }

    def cancel = {
        def trans = CashVoucher.get(params.id)

        if (trans) {

            trans.status = 'Cancelled'
            trans.approvalStatus = 'Denied'
            trans.save(flush:true)

            if (trans.hasErrors()) {
                println trans.errors

            }

            params.remarks = (params.remarks!=null && params.remarks.length()>0) ? params.remarks : 'Cancelled by ' + session.party.name
            def result = CashVoucherApproval.findAllByTransaction(trans)

            if (result) {
                for (int i = 0; i < result.size(); i++) {
                    if (result.get(i).position == session.employee.position) {
                        result.get(i).remarks = params.remarks
                        result.get(i).updatedBy = session.party
                        result.get(i).lastUpdated = new Date()
                        
                    }
                    result.get(i).status = 'Cancelled'
                    result.get(i).save(flush:true)
                }
            }

            flash.message = "${message(code: 'default.cancelled.message', args: [message(code: 'cashVoucher.cashVoucherNumber.label', default: 'CashVoucher'), trans.id])}"
            redirect(action: "show", id: trans.id)
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.cashVoucherNumber.label', default: 'CashVoucher'), trans.id])}"
            redirect(action: "list")
        }

    }

    def disbursement = {

        

        if (params.msg != null) {
            flash.message = params.msg
        }

        def disableCreate = 'no'

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'CASH_ADVANCE')) {
            flash.errors = "${message(code : 'approval.notFound')}"
            disableCreate = 'yes'
        }

        def result = cashSearchService.retrieveDisbursableTransactions(session.organization.id)

        def cashHistory = CashHistory.createCriteria()
        def history = cashHistory.list () {
            maxResults(1)
            order("id", "desc")
        }

        if (!cashVoucherService.checkForOpenReplenishments(session.organization.id)){
            flash.errors = "Unable to create a new Disbursement transaction. Resolve any open Replenishment transactions first."
            disableCreate = 'yes'
        }   
            
        [list: result, cashHistory : history.get(0), disableCreate : disableCreate]
        
        
    }

    def disburse = {

        def result = cashSearchService.retrieveDisbursableTransactions(session.organization.id)

        if (params.flags != null) {
            
            def valid = false
            for (int i = 0; i < params.flags.size(); i++) {
                if (params.flags[i] == '1') {
                    valid = true
                }
            }

            if (valid) {
                cashVoucherService.disburseVouchers(params, result)
            }

            def cashHistory = CashHistory.createCriteria()
            def history = cashHistory.list () {
                maxResults(1)
                order("id", "desc")
            }
            
            //render(view: "disbursement", model : [list: result, cashHistory : history.get(0)])
            redirect (action : "disbursement", params : [msg: "Disbursement successful."]);

        } else {

            redirect (action : "disbursement");

        }

    }

}
