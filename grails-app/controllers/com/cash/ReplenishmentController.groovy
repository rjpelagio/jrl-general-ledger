package com.cash

import com.app.*
import com.gl.*

class ReplenishmentController {

    def approvalService;
    def cashVoucherService;
    def cashSearchService;

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

        def disableCreate = 'yes'
        params.organization = session.organization.id

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'REPLENISHMENT')) {
        //if (!approvalCheck) {
            flash.errors = "${message(code : 'approval.notFound')}"
        } else {
            disableCreate = 'no'
        }

        if (!cashVoucherService.checkForOpenReplenishments(params.organization)){
            println 'uhh'
            flash.errors = "Unable to create a new Replenishment transaction. Resolve any open Replenishment transactions first."
            disableCreate = 'yes'
        }

        

        def result = cashSearchService.replenishmentSearchService(params)
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

        def trans = new Replenishment(params)

        [transList: result.subList(offset, toIndex), 
            transTotal: result.size(),
            trans : trans,
            offset : toIndex,
            disableCreate : disableCreate]
            
    }

    def create = {

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'REPLENISHMENT')) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        if (!cashVoucherService.checkForOpenReplenishments(session.organization.id)){
            flash.errors = "Unable to create a new Replenishment transaction. Resolve any open Replenishment transactions first."
            redirect(action:"list")
        }
        
        def trans = new Replenishment()

        def result = cashSearchService.retrieveReplenishableTransactions(session.organization.id)
        params.amount = 0.0
        params.change = 0.0

        if (result) {
            for (int i = 0; i < result.size(); i++) {
                params.amount += result[i].amount 
                params.change += result[i].change
            }
        }

        def cashHistory = CashHistory.createCriteria()
        def history = cashHistory.list () {
            maxResults(1)
            order("id", "desc")
        }

        def setup = CashSetup.get(1)

        [list: result, trans: trans, recordedCoh : history.get(0)]
    }


    def save = {

        def now = new Date()

        def trans = new Replenishment()
        trans.status = 'Active'
        processSaveSubmit(trans, params)
    }

    def submit = {

        if (params.formAction == 'create') {
            def trans = new Replenishment()
            trans.status = "Submitted"
            processSaveSubmit(trans, params)
        } else if (params.formAction == 'edit') {
            def trans = Replenishment.get(params.id)
            trans.status = "Submitted"
            processUpdateSubmit(trans, params)
        }
    }

    def update = {
        def trans = Replenishment.get(params.id)
        if (trans.status == "Submitted") {
            /* for updating already submitted transactions */
            params.formAction = "updateSubmitted"
        }
        processUpdateSubmit(trans, params)
    }

     def processSaveSubmit (Replenishment trans, def params) {

        def now = new Date()

        trans.approvalStatus = 'Pending Approval'
        trans.preparedBy = session.user.party
        trans.amount = params.amount.length() > 0 ? Float.parseFloat(params.amount) : 0
        trans.glAccount = GlAccount.get(params.glAccountId)
        trans.replenishmentNumber =  "RE" + now.format("yyMMddHHmmss")
        trans.description = params.description
        trans.organization = session.organization
        trans.dateCreated = now
        trans.change = params.change.length() > 0 ? Float.parseFloat(params.change) : 0

        params.amount = trans.amount
        params.change = trans.change

        if (trans.validate()) {
            if (trans.save(flush: true)) {

                //Save Replenishment denominations
                def replenishmentCash = new ReplenishmentCashItems(params);
                replenishmentCash.replenishment = trans
                replenishmentCash.save(flush:true)

                def result = cashSearchService.retrieveReplenishableTransactions(session.organization.id)
                if (result) {
                    cashVoucherService.saveAllReplenishableTransactions(trans,result)
                }

                if (trans.status == 'Submitted') {
                    cashVoucherService.validateReplenishmentApproval(trans, session, params.remarks, 'replenishment', params.formAction)
                    
                }

                flash.message = "${message(code: 'default.created.message', args: [message(code: 'replenishment.label', default: 'Replenishment'), trans.id])}"
                redirect(action: "show", id: trans.id)
            } else {
                
                def result = cashSearchService.retrieveReplenishableTransactions(session.organization.id)

                def cashHistory = CashHistory.createCriteria()
                def history = cashHistory.list () {
                    maxResults(1)
                    order("id", "desc")
                }

                render(view: "create", model: [list: result, trans: trans, recordedCoh : history.get(0)])
            }
        } else {
            
            def result = cashSearchService.retrieveReplenishableTransactions(session.organization.id)

            def cashHistory = CashHistory.createCriteria()
            def history = cashHistory.list () {
                maxResults(1)
                order("id", "desc")
            }
            
            render(view: "create", model: [list: result, trans: trans, recordedCoh : history.get(0)])
        }
    }

    def processUpdateSubmit (Replenishment trans, def params) {

        trans.glAccount = GlAccount.get(params.glAccountId)
        trans.description = params.description

        if (trans.validate()) {
            if (trans.save(flush: true)) {

                //Save Replenishment denominations
                def replenishmentCash = ReplenishmentCashItems.get(params.id);
                replenishmentCash.properties = params
                replenishmentCash.save(flush:true)

                if (trans.status == 'Submitted') {
                    cashVoucherService.validateReplenishmentApproval(trans, session, params.remarks, 'replenishment', params.formAction)
                }

                flash.message = "${message(code: 'replenishment.updated', args: [message(code: 'replenishment.label', default: 'Replenishment'), trans.replenishmentNumber])}"
                redirect(action: "show", id: trans.id)
            } else {
                
                def result = cashSearchService.retrieveReplenishableTransactions(session.organization.id)

                def cashHistory = CashHistory.createCriteria()
                def history = cashHistory.list () {
                    maxResults(1)
                    order("id", "desc")
                }

                render(view: "create", model: [list: result, trans: trans, recordedCoh : history.get(0)])
            }
        } else {
            
            def result = cashSearchService.retrieveReplenishableTransactions(session.organization.id)

            def cashHistory = CashHistory.createCriteria()
            def history = cashHistory.list () {
                maxResults(1)
                order("id", "desc")
            }
            
            render(view: "create", model: [list: result, trans: trans, recordedCoh : history.get(0)])
        }
    }

     def show = {

    
        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'REPLENISHMENT')) {
        //if (approvalCheck == false) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        def trans = Replenishment.get(params.id)
        if (!trans) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'replenishment.label', default: 'Replenishment'), params.id])}"
            redirect(action: "list")
        }

        else {

            def cashItem = ReplenishmentCashItems.findByReplenishment(trans)

            def approvalItems = ReplenishmentApproval.findAllByTransaction(trans, [sort: "sequence", order: "desc"])
            def showButtons =  true

            //def result = cashSearchService.retrieveReplenishableTransactions(session.organization.id)
            def result = ReplenishmentItems.findAllByReplenishment(trans)

            if (trans.status == 'Cancelled' || trans.status == 'Closed') {
                showButtons = false
            } else if (trans.status == 'Submitted') {
                def approvalSequence = ReplenishmentApproval.findByTransactionAndPosition(trans, session.employee.position)
                if (approvalSequence) {
                    if(approvalSequence.status == 'Submitted') {
                        showButtons = false
                    }
                }
            }

            [trans: trans, approvalItems : approvalItems, showButtons : showButtons, 
                cashItem : cashItem, list: result]
        }
    }

    def edit = {

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'REPLENISHMENT')) {
        //if (approvalCheck == false) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        def trans = Replenishment.get(params.id)
        if (!trans) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'replenishment.label', default: 'Replenishment'), params.id])}"
            redirect(action: "list")
        } else {

            def approvalItems = ReplenishmentApproval.findAllByTransaction(trans, [sort: "sequence", order: "desc"])
            def cashItem = ReplenishmentCashItems.findByReplenishment(trans)
            def result = cashSearchService.retrieveReplenishableTransactions(trans.organization.id)

            def showButtons =  true
            if (trans.status == 'Cancelled' || trans.status == 'Closed') {
                showButtons = false
            } else if (trans.status == 'Submitted') {
                def approvalSequence = ReplenishmentApproval.findByTransactionAndPosition(trans, session.employee.position)
                if (approvalSequence) {
                    if(approvalSequence.status == 'Submitted') {
                        showButtons = false
                    }
                }
            }

            [trans: trans, approvalItems : approvalItems, showButtons : showButtons, 
                cashItem : cashItem, list: result]
        }
    }

    def cancel = {
        def trans = Replenishment.get(params.id)

        if (trans) {

            trans.status = 'Cancelled'
            trans.approvalStatus = 'Denied'
            trans.save(flush:true)

            if (trans.hasErrors()) {
                println trans.errors
            }

            params.remarks = (params.remarks!=null && params.remarks.length()>0) ? params.remarks : 'Cancelled by ' + session.party.name
            def result = ReplenishmentApproval.findAllByTransaction(trans)

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

            flash.message = "${message(code: 'default.cancelled.message', args: [message(code: 'replenishment.number.label', default: 'Replenishment'), trans.id])}"
            redirect(action: "show", id: trans.id)
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'replenishment.number.label', default: 'Replenishment'), trans.id])}"
            redirect(action: "list")
        }

    }
}
