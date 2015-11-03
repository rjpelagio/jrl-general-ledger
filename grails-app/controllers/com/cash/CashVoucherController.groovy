package com.cash

import com.app.*

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

        approvalCheck = approvalService.checkApproval(session.employee.department, session.employee.position, 'VOUCHER')
        if (approvalCheck == false) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action: "list", params: params)
        }

    }



    def index = {
        redirect(action: "list", params: params)
    }

    def list = {

        def disableCreate = 'yes'

        //if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'VOUCHER')) {
        if (!approvalCheck) {
            flash.errors = "${message(code : 'approval.notFound')}"
        } else {
            disableCreate = 'no'
        }

        //Convert params.dateCreated to proper date string
        def map = new CashVoucher(params)
        params.dateCreated = map.dateCreated
        println params.sort 
        println params.order

        def result = cashSearchService.cashVoucherSearchService(params)
        //def result = CashVoucher.list()
        //println 'Controller Result : ' + result

        params.max = Math.min(params.max ? params.int('max') : 25, 100)
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

    def create = {

        def cashVoucherInstance = new CashVoucher()
        cashVoucherInstance.properties = params
        return [cashVoucherInstance: cashVoucherInstance]

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
            def trans = CashVoucher.get(params.transId)
            trans.status = "Submitted"
            processUpdateSubmit(trans, params)
        }
    }

    def show = {

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
                }
            }

            [cashVoucherInstance: cashVoucherInstance, approvalItems : approvalItems, showButtons : showButtons]
        }
    }

    def edit = {

        def cashVoucherInstance = CashVoucher.get(params.id)
        if (!cashVoucherInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [cashVoucherInstance: cashVoucherInstance]
        }
    }

    def update = {

        def cashVoucherInstance = CashVoucher.get(params.id)
        if (cashVoucherInstance) {
            cashVoucherInstance.properties = params
            if (!cashVoucherInstance.hasErrors() && cashVoucherInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), cashVoucherInstance.id])}"
                redirect(action: "show", id: cashVoucherInstance.id)
            }
            else {
                render(view: "edit", model: [cashVoucherInstance: cashVoucherInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), params.id])}"
            redirect(action: "list")
        }
    }

    def processSaveSubmit (CashVoucher cashVoucher, def params) {

        def now = new Date()

        cashVoucher.approvalStatus = 'Pending Approval'
        cashVoucher.transType = 'CASH_ADVANCE'
        cashVoucher.preparedBy = session.user.party
        cashVoucher.total = Double.parseDouble(params.total);
        cashVoucher.requestedBy = Party.get(params.requestedBy)
        cashVoucher.cashVoucherNumber =  now.format("yyMMddHHmmss")
        cashVoucher.description = params.description

        if (cashVoucher.validate()) {
            if (cashVoucher.save(flush: true)) {
                

                if (cashVoucher.status == 'Submitted') {
                    cashVoucherService.validateVoucherApproval(cashVoucher, session, params.remarks, 'cash_advance')
                }

                flash.message = "${message(code: 'default.created.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), cashVoucher.id])}"
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

        if (cashVoucher.validate()) {
            if (cashVoucher.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), cashVoucherInstance.id])}"
                redirect(action: "show", id: cashVoucherInstance.id)

                if (trans.status == 'Submitted') {
                    cashVoucherService.validateVoucherApproval(trans, session, params.remarks, 'cash_advance')
                } 
            }
            else {
                render(view: "edit", model: [cashVoucherInstance: cashVoucher])
            }
        } else {
            render(view: "edit", model : [cashVoucherInstance : cashVoucher])
        }
    }
}
