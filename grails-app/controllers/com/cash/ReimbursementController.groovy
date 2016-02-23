package com.cash

import com.app.*

class ReimbursementController {

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

}