package com.cash

import com.app.*
import com.gl.GlAccount

class ReimbursementController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def beforeInterceptor = [action:this.&auth]

    def approvalService;
    def cashVoucherService;
    def cashSearchService;

    private static boolean approvalCheck

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

        def result = cashSearchService.reimbursmentSearchService(params)
        //def result = CashVoucher.list()
        //println 'Controller Result : ' + result

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def offset = 0

        if(params.offset){
            offset = Math.min(params.offset ? params.int('offset') : 0, result.size())
        }
        def toIndex = offset + params.max
        if(toIndex>=result.size()){
            toIndex=result.size()
        }

        def cashVoucherInstance = new CashVoucher()

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cashVoucherInstanceList: result.subList(offset, toIndex), 
            cashVoucherInstanceTotal: result.size(),
            cashVoucherInstance : cashVoucherInstance,
            offset : toIndex,
            disableCreate : disableCreate]
            
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
            def transItems = CashVoucherItems.findAllByCashVoucher(trans) 
            return [cashVoucherInstance: trans, requestedBy : requestedBy, approvalItems : approvalItems, 
            transItems : transItems, rowNumber : transItems.size() - 1, 
            rowIndex : transItems.size(),]
        }
    }

    def create = {

        def trans = new CashVoucher()
        trans.properties = params
       
        //def approvalStatus = approvalService.checkApproval(session.employee.department, session.employee.position, 'CASH_ADVANCE')
        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'CASH_ADVANCE')) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }
        trans.properties = params
        def payeeIds = [:]

        return [cashVoucherInstance: trans, payeeIds : payeeIds]

    }

    def save = {
        def trans = new CashVoucher()
        trans.status = "Active"
        processSaveSubmit(trans, params)
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

    def update = {
        def trans = CashVoucher.get(params.id)
        if (trans.status == "Submitted") {
            /* for updating already submitted transactions */
            params.formAction = "updateSubmitted"
        }
        processUpdateSubmit(trans, params)
    }

    

    def processSaveSubmit (CashVoucher trans, def params) {
        
        def now = new Date()

        trans.approvalStatus = 'Pending Approval'
        trans.transType = 'REIMBURSEMENT'
        trans.preparedBy = session.user.party
        trans.total = params.total.length() > 0 ? Double.parseDouble(params.total) : 0
        params.total = trans.total
        trans.requestedBy = Party.get(params.requestedBy)
        trans.cashVoucherNumber =  now.format("yyMMddHHmmss")
        trans.description = params.description
        trans.glAccount = GlAccount.get(params.glAccountId)
        trans.payee = Party.get(params.payee)


        def glAccountIds = [:]
        def glAccounts = [:]
        if (params.department == 'Finance') {
            glAccountIds = params.glAccountIds
            glAccounts = params.glAccounts
        }
        def descriptions = params.descriptions;
        def payees = params.payees;
        def payeeIds = params.payeeIds;
        def refDocs = params.refDocs;
        def tintexts = params.tintexts;
        def amounts = params.amounts;

        def approvalMsg = ''
        if (trans.validate()) {

            def msgs = cashVoucherService.validateReimbursementItems(params)
            
            
            if (msgs.size() == 0) {
                if (trans.save(flush:true)) {
                    cashVoucherService.insertReimbursementItems(trans,
                        payeeIds,
                        amounts,
                        descriptions,
                        refDocs,
                        glAccountIds,
                        params.department
                    )

                    if (trans.status == 'Submitted') {
                        approvalMsg = cashVoucherService.validateVoucherApproval(trans, session, params.remarks, 'cash_advance', params.formAction)
                    }
                }
                
                
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'reimburse.label', default: 'Reimbursement'), trans.cashVoucherNumber])}"
            redirect(action: "show", id: trans.id)

            } else {

                msgs.add(approvalMsg)
                flash.batchMsgs = msgs


                render(view: "create", model: [cashVoucherInstance: trans, 
                descriptions : descriptions,
                payees : payees,
                refDocs : refDocs,
                tintexts : tintexts,
                amounts : amounts,
                payeeIds : payeeIds,
                glAccountIds : glAccountIds,
                glAccounts : glAccounts,
                rowNumber : params.rowNumber,
                rowIndex : params.rowIndex])
            }

        } else {

            render(view: "create", model: [cashVoucherInstance: trans, 
                descriptions : descriptions,
                payees : payees,
                refDocs : refDocs,
                tintexts : tintexts,
                amounts : amounts,
                payeeIds : payeeIds,
                tintexts : params.tintexts,
                glAccountIds : glAccountIds,
                glAccounts : glAccounts,
                rowNumber : params.rowNumber,
                rowIndex : params.rowIndex])

        }

    }

    def processUpdateSubmit (CashVoucher trans, def params) {

        trans.total = params.total.length() > 0 ? Double.parseDouble(params.total) : 0
        params.total = trans.total
        trans.requestedBy = Party.get(params.requestedBy)
        trans.description = params.description
        trans.glAccount = GlAccount.get(params.glAccountId)
        trans.payee = Party.get(params.payee)
        
        def glAccountIds = [:]
        def glAccounts = [:]
        if (params.department == 'Finance') {
            glAccountIds = params.glAccountIds
            glAccounts = params.glAccounts
        }
        def descriptions = params.descriptions;
        def payees = params.payees;
        def payeeIds = params.payeeIds;
        def refDocs = params.refDocs;
        def tintexts = params.tintexts;
        def amounts = params.amounts;

          if (trans.validate()) {

            def msgs = cashVoucherService.validateReimbursementItems(params)
            def approvalMsg = ''
            
            if (msgs.size() == 0) {
                if (trans.save(flush:true)) {

                    //remove previously recorded reimbursement items
                    CashVoucherItems.executeUpdate("delete \
                    CashVoucherItems items \
                    WHERE items.cashVoucher = ?", [trans]);

                    cashVoucherService.insertReimbursementItems(trans,
                        payeeIds,
                        amounts,
                        descriptions,
                        refDocs,
                        glAccountIds,
                        params.department
                    )

                    if (trans.status == 'Submitted') {
                        approvalMsg = cashVoucherService.validateVoucherApproval(trans, session, params.remarks, 'cash_advance', params.formAction)
                    }
                }
                
                
            flash.message = "${message(code: 'reimburse.updated', args: [message(code: 'reimburse.label', default: 'Reimbursement'), trans.cashVoucherNumber])}"
            redirect(action: "show", id: trans.id)

            } else {

                msgs.add(approvalMsg)
                flash.batchMsgs = msgs

                render(view: "edit", model: [cashVoucherInstance: trans, 
                transItems : CashVoucherItems.findAllByCashVoucher(trans), 
                rowNumber : transItems.size() - 1, 
                rowIndex : transItems.size()])
            }

        } else {

            render(view: "edit", model: [cashVoucherInstance: trans, 
                transItems : CashVoucherItems.findAllByCashVoucher(trans),
                rowNumber : transItems.size() - 1, 
                rowIndex : transItems.size()])

        }

    }

    def show = {

    
        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'CASH_ADVANCE')) {
        //if (approvalCheck == false) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        def cashVoucherInstance = CashVoucher.get(params.id)
        if (!cashVoucherInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
            redirect(action: "list")
        }
        else {

            def transItems = CashVoucherItems.findAllByCashVoucher(cashVoucherInstance)

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
                }
            }

            [cashVoucherInstance: cashVoucherInstance, approvalItems : approvalItems, showButtons : showButtons, transItems : transItems]
        }
    }

}