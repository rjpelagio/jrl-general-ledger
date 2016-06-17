package com.cash

import com.app.*
import com.gl.GlAccount

class LiquidationController {

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

    def list = {

        def disableCreate = 'yes'

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'LIQUIDATION')) {
        //if (!approvalCheck) {
            flash.errors = "${message(code : 'approval.notFound')}"
        } else {
            disableCreate = 'no'
        }

        if (!cashVoucherService.checkForOpenReplenishments(session.organization.id)){
            flash.errors = "Unable to create a new Liquidation transaction. Resolve any open Replenishment transactions first."
            redirect(action:"list")
        }

        def map = new Liquidation(params)
        params.dateCreated = map.dateCreated
        params.organization = session.organization.id
        
        def result = cashSearchService.liquidationSearchService(params)

        params.max = Math.min(params.max ? params.int('max') : 10, 10)
        def offset = 0

        if(params.offset){
            offset = Math.min(params.offset ? params.int('offset') : 0, result.size())
        }
        def toIndex = offset + params.max
        if(toIndex>=result.size()){
            toIndex=result.size()
        }

        def liquidation = new Liquidation()

        [liquidationList: result.subList(offset, toIndex), 
            liquidationTotal: result.size(),
            trans : map,
            offset : toIndex,
            disableCreate : disableCreate]
    }

    def create = {

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'LIQUIDATION')) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        if (!cashVoucherService.checkForOpenReplenishments(session.organization.id)){
            flash.errors = "Unable to create a new Liquidation transaction. Resolve any open Replenishment transactions first."
            redirect(action:"list")
        }


        def cashVoucherCriteria = CashVoucher.createCriteria()
        def cashVoucherList = cashVoucherCriteria.list () {
            and {
                eq ("status", "Disbursed")
                eq ("approvalStatus", "Approved")
                eq ("transType", "CASH_ADVANCE")
            }
            order("dateCreated", "asc")
        }

        def payeeIds = [:]

        def trans = new Liquidation()

        if (params.cashVoucher != null || params.cashVoucher != '') {

            def cashVoucherInstance = CashVoucher.get(params.cashVoucher)


            return [cashVoucherList: cashVoucherList, cashVoucherInstance : cashVoucherInstance, payeeIds : payeeIds, trans : trans]
       
        } else {

            return [cashVoucherList: cashVoucherList, payeeIds : payeeIds, trans : trans]

        }

    }

    def load = {

        redirect (action : "create",  params : [cashVoucher: params.cashVoucher]);

    }

    def edit = {

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'LIQUIDATION')) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        if (!cashVoucherService.checkForOpenReplenishments(session.organization.id)){
            flash.errors = "Unable to edit any Liquidation transaction. Resolve any open Replenishment transactions first."
            redirect(action:"list")
        }

        def trans = Liquidation.get(params.id)
        if (!trans) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'liquidation.label', default: 'Liquidation'), params.id])}"
            redirect(action: "list")
        }
        else {
            def cashVoucherInstance = CashVoucher.get(trans.cashVoucher.id)
            def approvalItems = LiquidationApproval.findAllByTransaction(trans, [sort: "sequence", order: "desc"])
            def transItems = LiquidationItems.findAllByLiquidation(trans) 
            return [trans: trans, 
            cashVoucherInstance : cashVoucherInstance,
            approvalItems : approvalItems, 
            transItems : transItems,
            rowNumber : transItems.size() - 1, 
            rowIndex : transItems.size(),]
        }
    }



    def save = {
            def trans = new Liquidation()
            trans.status = "Active"
            processSaveSubmit(trans, params)
    }

    def submit = {
        if (params.formAction == 'create') {
            def trans = new Liquidation()
            trans.status = "Submitted"
            processSaveSubmit(trans, params)
        } else if (params.formAction == 'edit') {
            def trans = Liquidation.get(params.id)
            trans.status = "Submitted"
            processUpdateSubmit(trans, params)
        }
    }

    def update = {
        def trans = Liquidation.get(params.id)
        if (trans.status == "Submitted") {
            /* for updating already submitted transactions */
            params.formAction = "updateSubmitted"
        }
        processUpdateSubmit(trans, params)
    }


    def processSaveSubmit (Liquidation trans, def params) {
        
        def now = new Date()

        trans.approvalStatus = 'Pending Approval'
        trans.preparedBy = session.user.party
        trans.liquidationNumber = "LI" + now.format("yyMMddHHmmss")
        trans.description = 'Liquidation for Cash Voucher ' + params.cashVoucherNo
        trans.dateCreated = new Date()
        trans.cashVoucher = CashVoucher.get(params.cashVoucher)
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

        def glAccountIds = params.glAccountIds
        def glAccounts = params.glAccounts
        def descriptions = params.descriptions;
        def payees = params.payees;
        def payeeIds = params.payeeIds;
        def refDocs = params.refDocs;
        def tintexts = params.tintexts;
        def amounts = params.amounts;

        def cashVoucherInstance = CashVoucher.get(params.cashVoucher)
        trans.change = cashVoucherInstance.total - trans.total

        def approvalMsg = ''
        if (trans.validate()) {

            def msgs = cashVoucherService.validateLiquidationItems(params)
            boolean validCashVoucher = cashVoucherService.checkCashVoucherForLiquidation(cashVoucherInstance)
            if (!validCashVoucher) {
                msgs.add("Cannot create Liquidation. Given Cash Voucher is on another Liquidation form.")
            }
            
            if (msgs.size() == 0) {
                if (trans.save(flush:true)) {

                    cashVoucherService.insertLiquidationItems(trans,
                                payeeIds,
                                amounts,
                                descriptions,
                                glAccountIds,
                                refDocs
                            )

                            if (trans.status == 'Submitted') {
                                approvalMsg = cashVoucherService.validateLiquidationApproval(trans, session, params.remarks, 'liquidation', params.formAction)
                                def cashVoucherEntry = CashVoucher.get(params.cashVoucher)
                                cashVoucherEntry.change = trans.change
                                cashVoucherEntry.status = 'Liquidated'
                                cashVoucherEntry.save(flush:true)
                            }
                }


                flash.message = "${message(code: 'default.created.message', args: [message(code: 'liquidation.label', default: 'Reimbursement'), trans.liquidationNumber])}"
                redirect(action: "show", id: trans.id) 

            } else {

                flash.batchMsgs = msgs
                def cashVoucherCriteria = CashVoucher.createCriteria()
                def cashVoucherList = cashVoucherCriteria.list () {
                    and {
                        eq ("status", "Disbursed")
                        eq ("approvalStatus", "Approved")
                        eq ("transType", "CASH_ADVANCE")
                    }
                    order("dateCreated", "asc")
                }

                render(view: "create", model: [cashVoucherInstance : cashVoucherInstance,
                trans: trans, 
                descriptions : descriptions,
                cashVoucherList : cashVoucherList,
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

            def cashVoucherCriteria = CashVoucher.createCriteria()
            def cashVoucherList = cashVoucherCriteria.list () {
                and {
                    eq ("status", "Disbursed")
                    eq ("approvalStatus", "Approved")
                    eq ("transType", "CASH_ADVANCE")
                }
                order("dateCreated", "asc")
            }

            render(view: "create", model: [cashVoucherInstance: cashVoucherInstance, 
                trans: trans,
                descriptions : descriptions,
                cashVoucherList : cashVoucherList,
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

    def processUpdateSubmit (Liquidation trans, def params) {

        def now = new Date()

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

        def glAccountIds = params.glAccountIds
        def glAccounts = params.glAccounts
        def descriptions = params.descriptions;
        def payees = params.payees;
        def payeeIds = params.payeeIds;
        def refDocs = params.refDocs;
        def tintexts = params.tintexts;
        def amounts = params.amounts;

        def cashVoucherInstance = CashVoucher.get(trans.cashVoucher.id)
        trans.change = cashVoucherInstance.total - trans.total

        if (trans.validate()) {

            def msgs = cashVoucherService.validateLiquidationItems(params)

            if (msgs.size() == 0) {
                if (trans.save(flush:true)) {

                    cashVoucherService.insertLiquidationItems(trans,
                                payeeIds,
                                amounts,
                                descriptions,
                                glAccountIds,
                                refDocs
                            )

                    if (trans.status == 'Submitted') {
                        cashVoucherService.validateLiquidationApproval(trans, session, params.remarks, 'liquidation', params.formAction)
                    }
                }
                
                
            flash.message = "${message(code: 'liquidation.updated', args: [message(code: 'liquidation.label', default: 'Liquidation'), trans.liquidationNumber])}"
            redirect(action: "show", id: trans.id)

            } else {

                flash.batchMsgs = msgs

                render(view: "edit", model: [trans: trans, 
                cashVoucherInstance: cashVoucherInstance,
                transItems : LiquidationItems.findAllByLiquidation(trans), 
                rowNumber : transItems.size() - 1, 
                rowIndex : transItems.size()])
            }

        } else {

            render(view: "edit", model: [trans: trans, 
                cashVoucherInstance : cashVoucherInstance,
                transItems : LiquidationItems.findAllByLiquidation(trans),
                rowNumber : transItems.size() - 1, 
                rowIndex : transItems.size()])

        }

    }

    def show = {

    
        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'LIQUIDATION')) {
        //if (approvalCheck == false) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        def trans = Liquidation.get(params.id)
        if (!trans) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'liquidation.label', default: 'Liquidation'), params.id])}"
            redirect(action: "list")
        }
        else {

            def transItems = LiquidationItems.findAllByLiquidation(trans)

            def approvalItems = LiquidationApproval.findAllByTransaction(trans, [sort: "sequence", order: "desc"])
            def showButtons =  true

            if (trans.status == 'Cancelled' || trans.status == 'Closed') {
                showButtons = false
            } else if (trans.status == 'Submitted') {
                def approvalSequence = LiquidationApproval.findByTransactionAndPosition(trans, session.employee.position)
                if (approvalSequence) {
                    if(approvalSequence.status == 'Submitted') {
                        showButtons = false
                    }
                }
            }

            [trans: trans, approvalItems : approvalItems, showButtons : showButtons, transItems : transItems]
        }
    }

    def cancel = {
        def trans = Liquidation.get(params.id)

        if (trans) {

            trans.status = 'Cancelled'
            trans.approvalStatus = 'Denied'
            trans.save(flush:true)

            if (trans.hasErrors()) {
                println trans.errors

            }

            params.remarks = (params.remarks!=null && params.remarks.length()>0) ? params.remarks : 'Cancelled by ' + session.party.name
            def result = LiquidationApproval.findAllByTransaction(trans)

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

            flash.message = "${message(code: 'default.cancelled.message', args: [message(code: 'liquidation.label', default: 'CashVoucher'), trans.liquidationNumber])}"
            redirect(action: "show", id: trans.id)
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'liquidation.label', default: 'CashVoucher'), trans.liquidationNumber])}"
            redirect(action: "list")
        }

    }
    
}
