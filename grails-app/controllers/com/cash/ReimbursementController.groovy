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

        params.organization = session.organization.id

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

        def setup = CashSetup.get(1)

        return [cashVoucherInstance: trans, payeeIds : payeeIds, setup : setup]

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
        trans.requestedBy = Party.get(params.requestedBy)
        trans.cashVoucherNumber = "RI" + now.format("yyMMddHHmmss")
        trans.description = params.description
        trans.glAccount = GlAccount.get(params.glAccountId)
        trans.payee = Party.get(params.payee)
        //trans.total = params.total.length() > 0 ? Float.parseFloat(params.total) : 0
        if (params.rowIndex.toInteger() > 1) {
            for (int i = 0; i < params.amounts.size(); i++) {
                try {
                    if (params.amounts[i].toFloat()) {
                        trans.total += params.amounts[i].toFloat()
                    } else {
                        trans.total += 0;
                    }
                } catch (all) {
                    trans.total += 0;
                } 
            }
        } else {
            trans.total = Float.parseFloat(params.amounts)
        }
        params.total = trans.total
        trans.organization = session.organization

        //def transItems= cashVoucherItems.findAllByCashVoucher(trans) 
        def glAccountIds = [:]
        def glAccounts = [:]
        if (params.department == 'Finance') {
            glAccountIds = params.list('glAccountIds')
            glAccounts = params.list('glAccounts')
        }
        def descriptions = params.list('descriptions');
        def payees = params.list('payees');
        def payeeIds = params.list('payeeIds');
        def refDocs = params.list('refDocs');
        def tintexts = params.list('tintexts'); 
        def amounts = params.list('amounts');



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
                        cashVoucherService.validateVoucherApproval(trans, session, params.remarks, 'cash_advance', params.formAction)
                    }
                }
                
                
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'reimburse.label', default: 'Reimbursement'), trans.cashVoucherNumber])}"
            redirect(action: "show", id: trans.id)

            } else {


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
        
        trans.requestedBy = Party.get(params.requestedBy)
        trans.description = params.description
        trans.glAccount = GlAccount.get(params.glAccountId)
        trans.payee = Party.get(params.payee)
        //trans.total = params.total.length() > 0 ? Float.parseFloat(params.total) : 0
        //if (params.rowIndex.toInteger() > 1) {
        //    for (int i = 0; i < params.amounts.size(); i++) {
        //        try {
        //            if (params.amounts[i].toFloat()) {
       //                 trans.total += params.amounts[i].toFloat()
       //             } else {
        //                trans.total += 0;
       //             }
        //        } catch (all) {
        //            trans.total += 0;
      //          } 
        //    }
    //    } else {
      //      trans.total = Float.parseFloat(params.amounts)
      //  }
        trans.total = Float.parseFloat(params.total) ? Float.parseFloat(params.total) : 0
        //params.total = trans.total3

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

        def transItems = CashVoucherItems.findAllByCashVoucher(trans)

          if (trans.validate()) {

            def msgs = cashVoucherService.validateReimbursementItems(params)
            def approvalMsg = ''
            
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

}