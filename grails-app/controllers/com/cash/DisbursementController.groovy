package com.cash

import com.app.*

class DisbursementController {

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

        if (!approvalService.checkApproval(session.employee.department, session.employee.position, 'DISBURSEMENT')) {
        //if (!approvalCheck) {
            flash.errors = "${message(code : 'approval.notFound')}"
        } else {
            disableCreate = 'no'
        }

        def map = new Disbursement(params)
        params.dateCreated = map.dateCreated

        def result = cashSearchService.reimbursmentSearchService(params)

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def offset = 0

        if(params.offset){
            offset = Math.min(params.offset ? params.int('offset') : 0, result.size())
        }
        def toIndex = offset + params.max
        if(toIndex>=result.size()){
            toIndex=result.size()
        }
        
        def trans = new Disbursement()

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [disbursementList: result.subList(offset, toIndex), 
            disbursementTotal: result.size(),
            trans : trans,
            offset : toIndex,
            disableCreate : disableCreate]
    }

    def create = {
        def disbursementInstance = new Disbursement()
        disbursementInstance.properties = params

        def requestList = CashVoucher.findAllByApprovalStatus('Approved')


        return [disbursementInstance: disbursementInstance, requestList : requestList]
    }

    def save = {
        def disbursementInstance = new Disbursement(params)
        if (disbursementInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'disbursement.label', default: 'Disbursement'), disbursementInstance.id])}"
            redirect(action: "show", id: disbursementInstance.id)
        }
        else {
            render(view: "create", model: [disbursementInstance: disbursementInstance])
        }
    }

    def show = {
        def disbursementInstance = Disbursement.get(params.id)
        if (!disbursementInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'disbursement.label', default: 'Disbursement'), params.id])}"
            redirect(action: "list")
        }
        else {
            [disbursementInstance: disbursementInstance]
        }
    }

    def edit = {
        def disbursementInstance = Disbursement.get(params.id)
        if (!disbursementInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'disbursement.label', default: 'Disbursement'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [disbursementInstance: disbursementInstance]
        }
    }

    def update = {
        def disbursementInstance = Disbursement.get(params.id)
        if (disbursementInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (disbursementInstance.version > version) {
                    
                    disbursementInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'disbursement.label', default: 'Disbursement')] as Object[], "Another user has updated this Disbursement while you were editing")
                    render(view: "edit", model: [disbursementInstance: disbursementInstance])
                    return
                }
            }
            disbursementInstance.properties = params
            if (!disbursementInstance.hasErrors() && disbursementInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'disbursement.label', default: 'Disbursement'), disbursementInstance.id])}"
                redirect(action: "show", id: disbursementInstance.id)
            }
            else {
                render(view: "edit", model: [disbursementInstance: disbursementInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'disbursement.label', default: 'Disbursement'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def disbursementInstance = Disbursement.get(params.id)
        if (disbursementInstance) {
            try {
                disbursementInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'disbursement.label', default: 'Disbursement'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'disbursement.label', default: 'Disbursement'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'disbursement.label', default: 'Disbursement'), params.id])}"
            redirect(action: "list")
        }
    }
}
