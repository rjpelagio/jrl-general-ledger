package com.gl

import grails.converters.deep.JSON
import com.app.*
import groovy.sql.Sql

class GlAccountingTransactionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def beforeInterceptor = [action:this.&auth]
    
    def glSearchService;
    def glAcctgTransactionService;
    def approvalService;

    def dataSource;

    def auth() {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }

    }

    def index = {
        redirect(action: "list", params: params)
    }

    def showTin = {
        def party = Party.get(params.id)
        render party as JSON
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        def glAccountingTransactionInstance = new GlAccountingTransaction()
        def offset = 0
        
        def result = glSearchService.getAcctgTrans(
            session.organization, params.description, params.voucherNo, params.status, params.acctgTransType, params.transactionDate, params.entryDate
        )

        if(params.offset){
            offset = Math.min(params.offset ? params.int('offset') : 0, result.size())
        }
        def toIndex = offset + params.max
        if(toIndex>=result.size()){
            toIndex=result.size()
        }

        def disableCreate = 'no';
        def approvalStatus = approvalService.checkApproval(session.employee.department, session.employee.position, 'VOUCHER')
        if (approvalStatus == false) { 
            flash.errors = "${message(code : 'approval.notFound')}"
            disableCreate = 'yes';
        }

        [glAccountingTransactionInstanceList: result.subList(offset, toIndex), glAccountingTransactionInstanceTotal: result.size(), glAccountingTransactionInstance: glAccountingTransactionInstance, offset : toIndex, disableCreate : disableCreate]
    }

    def create = {

        def approvalStatus = approvalService.checkApproval(session.employee.department, session.employee.position, 'VOUCHER')
        if (approvalStatus == false) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        def glAccountingTransactionInstance = new GlAccountingTransaction()
        glAccountingTransactionInstance.properties = params
        def glAccounts = [:];
        def debit = 0.00;
        def credit = 0.00;
        
        return [glAccountingTransactionInstance: glAccountingTransactionInstance, 
            glAccounts : glAccounts,
            debit : debit,
            credit : credit,
            payeeText : '',
            tinText : 'N/A']
    }

    def submit = {
        if (params.formAction == 'create') {
            def trans = new GlAccountingTransaction(params)
            trans.status = "Submitted"
            processSaveSubmit(trans, params)
        } else if (params.formAction == 'edit') {
            def trans = GlAccountingTransaction.get(params.transId)
            trans.status = "Submitted"
            processUpdateSubmit(trans, params)
        }
    }
    
    def save = {
        def trans = new GlAccountingTransaction(params)
        trans.status = "Active"
        processSaveSubmit(trans, params)
    }

    def show = {
        def approvalStatus = approvalService.checkApproval(session.employee.department, session.employee.position, 'VOUCHER')

        if (approvalStatus == false) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }
        
        def trans = GlAccountingTransaction.get(params.id)
        
        if (!trans) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
            redirect(action: "list")       
        } else {
            
            def transItems = GlAccountingTransactionDetails.findAllByGlAccountingTransaction(trans);
            def approvalItems = VoucherApproval.findAllByTransaction(trans, [sort: "sequence", order: "desc"])
            def showButtons =  true

            if (trans.status == 'Cancelled' || trans.status == 'Closed') {
                showButtons = false
            } else if (trans.status == 'Submitted') {
                def approvalSequence = VoucherApproval.findByTransactionAndPosition(trans, session.employee.position)
                if (approvalSequence) {
                    if(approvalSequence.status == 'Submitted') {
                        showButtons = false
                    }
                }
            }

            [glAccountingTransactionInstance: trans, transItems : transItems, approvalItems : approvalItems, showButtons : showButtons]
        }
    }

    def update = {
        def trans = GlAccountingTransaction.get(params.transId)
        processUpdateSubmit(trans, params)
    }

     def processSaveSubmit (GlAccountingTransaction trans, def params) {

        trans.organization = session.organization
        trans.entryDate = trans.transactionDate
        trans.party = Party.get(params.partyId)
        trans.approvalStatus = "Pending Approval"
        trans.acctgTransType = AcctgTransType.get(params.transType)
        trans.preparedBy = session.user.party 

        if (!trans.entryDate) {
             trans.entryDate = new Date()
        }

        def glAccounts = params.glAccounts;
        def glAccountIds = params.glAccountIds;
        def debits = params.debits;
        def credits = params.credits;
        def debit = params.debit;
        def credit = params.credit;

         if (trans.validate()) {

            def msgs = glAcctgTransactionService.validateTransItems(glAccounts, glAccountIds)
            def approvalMsg = ''
            

            if (msgs.size() == 0) {

                trans.save(flush:true)
                glAcctgTransactionService.insertAcctgTrans(
                    trans,
                    glAccountIds,
                    debits,
                    credits
                )

                if (trans.status == 'Submitted') {
                    approvalMsg = glAcctgTransactionService.validateVoucherApproval(trans, session, params.remarks, 'voucher')
                }
            

            flash.message = "${message(code: 'default.created.message', args: [message(code: 'trans.label', default: 'GlAccountingTransaction'), trans.id])}"
            redirect(action: "show", id: trans.id)

            } else {

                msgs.add(approvalmsg)
                flash.batchMsgs = msgs

                render(view: "create", model: [glAccountingTransactionInstance: trans, 
                glAccounts : glAccounts,
                glAccountIds : glAccountIds,
                debits : debits,
                credits : credits,
                debit : debit,
                credit : credit,
                payeeText : params.payeeText,
                tinText : params.tinText,
                rowNumber : params.rowNumber,
                rowIndex : params.rowIndex])
            }

        } else {

            render(view: "create", model: [glAccountingTransactionInstance: trans, 
                glAccounts : glAccounts,
                glAccountIds : glAccountIds,
                debits : debits,
                credits : credits,
                debit : debit,
                credit : credit,
                payeeText : params.payeeText,
                tinText : params.tinText,
                rowNumber : params.rowNumber,
                rowIndex : params.rowIndex])

        }

    }

    def processUpdateSubmit (GlAccountingTransaction trans, def params) {

        trans.properties = params
        trans.entryDate = trans.transactionDate
        trans.party = Party.get(params.partyId)
        trans.acctgTransType = AcctgTransType.get(params.transType)
        
        if (!trans.entryDate) {
             trans.entryDate = new Date()
        }

        def glAccounts = params.glAccounts;
        def glAccountIds = params.glAccountIds;
        def debits = params.debits;
        def credits = params.credits;
        def debit = params.debit;
        def credit = params.credit;

         if (trans.validate()) {

            def msgs = glAcctgTransactionService.validateTransItems(glAccounts, glAccountIds)

            if (msgs.size() == 0) {

                trans.save(flush:true)
                //remove old items
                GlAccountingTransactionDetails.executeUpdate("delete \
                    GlAccountingTransactionDetails items \
                    WHERE items.glAccountingTransaction = ?", [trans]);
                glAcctgTransactionService.insertAcctgTrans(
                    trans,
                    glAccountIds,
                    debits,
                    credits
                )

                if (trans.status == 'Submitted') {
                    glAcctgTransactionService.validateVoucherApproval(trans, session, params.remarks, 'voucher')
                }

            flash.message = "${message(code: 'glAccountingTransaction.updated', args: [message(code: 'trans.label', default: 'GlAccountingTransaction'), trans.id])}"
            redirect(action: "show", id: trans.id)

            } else {


                flash.batchMsgs = msgs

                render(view: "edit", model: [glAccountingTransactionInstance: trans, 
                glAccounts : glAccounts,
                glAccountIds : glAccountIds,
                debits : debits,
                credits : credits,
                debit : debit,
                credit : credit,
                payeeText : params.payeeText,
                tinText : params.tinText,
                rowNumber : params.rowNumber,
                rowIndex : params.rowIndex])
            }

        } else {

            render(view: "edit", model: [glAccountingTransactionInstance: trans, 
                glAccounts : glAccounts,
                glAccountIds : glAccountIds,
                debits : debits,
                credits : credits,
                debit : debit,
                credit : credit,
                payeeText : params.payeeText,
                tinText : params.tinText,
                rowNumber : params.rowNumber,
                rowIndex : params.rowIndex])

        }

    }

    def cancel = {
        def trans = GlAccountingTransaction.get(params.transId)

        if (trans) {

            trans.status = 'Cancelled'
            trans.approvalStatus = 'Denied'
            trans.save(flush:true);

            params.remarks = (params.remarks!=null && params.remarks.length()>0) ? params.remarks : 'Cancelled by ' + session.party.name
            def result = VoucherApproval.findAllByTransaction(trans)

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

            flash.message = "${message(code: 'default.cancelled.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), trans.id])}"
            redirect(action: "show", id: trans.id)
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
            redirect(action: "list")
        }

    }

    def edit = {
        
        def approvalStatus = approvalService.checkApproval(session.employee.department, session.employee.position, 'VOUCHER')
        if (approvalStatus == false) {
            flash.errors = "${message(code : 'approval.notFound')}"
            redirect(action:"list")
        }

        def trans = GlAccountingTransaction.get(params.transId)
        def debits = [:]
        def credits = [:]
        def glAccountIds = [:]
        def glAccounts = [:]

        if (!trans) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
            redirect(action: "list")
        }

        def items = GlAccountingTransactionDetails.findAllByGlAccountingTransaction(trans)

        //prep items for screen entries
        for (int i = 0; i < items.size() ; i++) { 
            glAccounts[i] = GlAccount.find(items.get(i).glAccount)
            glAccountIds[i] = glAccounts[i].id
            if (items.get(i).debitCreditFlag == 'Debit') {
                debits[i] = items.get(i).amount
                credits[i] = 0
            } else if (items.get(i).debitCreditFlag == 'Credit') {
                debits[i] = 0
                credits[i] = items.get(i).amount
            }
        }

        //prepare approval items

        def approvalItems = VoucherApproval.findAllByTransaction(trans, [sort: "sequence", order: "desc"])

         render(view: "edit", model: [glAccountingTransactionInstance: trans, 
            glAccounts : glAccounts, 
            glAccountIds : glAccountIds,
            rowNumber : glAccounts.size() - 1, 
            rowIndex : glAccounts.size(),
            debits : debits,
            credits : credits,
            payeeText : trans.party.name,
            tinText : trans.party.tin,
            approvalItems : approvalItems])

    }
    
    def delete = {
        def glAccountingTransactionInstance = GlAccountingTransaction.get(params.id)
        if (glAccountingTransactionInstance) {
            try {
                glAccountingTransactionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def lookupSearchAction = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.description = "Cash"
        def gl = new GlAccount();
        gl.properties = params.properties;
        def glAccountInstanceList = glSearchService.getGlAccounts(
            gl.glAccount, gl.description, gl.glAccountType
        );
        def glAccountInstanceTotal = glAccountList.size();
        glAccountInstanceList = GlAccount.list(params);
        
        redirect(action: "create", model:[glAccountList : glAccountList, glAccountInstanceTotal : glAccountInstanceTotal])
        render glAccountList as JSON
        
    }

    def approve = {
        def glAcctgTransaction = GlAccountingTransaction.get(params.id)
        //def acctgTransApproval = AcctgTransApproval.findAllByAcctgTrans(glAcctgTransaction)
        def db = new Sql(dataSource)
        def acctgTrans = db.firstRow("SELECT b.id, a.remarks FROM approval_seq a LEFT JOIN acctg_trans_approval b\
                ON a.id=b.approval_seq_id\
                WHERE user_id is null and acctg_trans_id ="+ params.id +" and role_id="+ session.user.role.id+" ORDER BY sequence")
        def acctgTransApproval = AcctgTransApproval.get(acctgTrans.id)
        acctgTransApproval.properties = params
        acctgTransApproval.id = acctgTrans.id
        acctgTransApproval.user = session.user
            if (!acctgTransApproval.hasErrors() && acctgTransApproval.save(flush: true)) {
                if(acctgTrans.remarks=='Approved by'){
                    glAcctgTransactionService.approve(params.id)
                }
                flash.message = "${message(code: 'glAccountingTransaction.approved', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
                redirect(action: "show", id: glAcctgTransaction.id)
            }
            else {
                render(view: "edit", model: [glAccountTypeInstance: glAccountTypeInstance])
            }
    }

    def consol = {
        def orgId = session.organization.id
        
        def dropDown = AcctgPeriod.executeQuery("\
            FROM AcctgPeriod ap\
            WHERE ap.status = ?\
            AND ap.organization = ?\
            ORDER BY ap.fromDate", ["Open", session.organization]
        )

        def currentPeriod = com.gl.AcctgPeriod.executeQuery("\
            FROM AcctgPeriod ap\
            WHERE status = ?\
            ORDER BY fromDate", ["Open"])

        def currentPeriodInstance = currentPeriod[0].id

        if(params.acctgPeriod) {
            currentPeriodInstance = Integer.parseInt(params.acctgPeriod)
        }
        
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def result = glAcctgTransactionService.consolResult(currentPeriodInstance, orgId)
        
        [glAcctConsolInstanceList: result.asList() , glAcctConsolInstanceTotal: result.size(), dropDown : dropDown, currentPeriodInstance : currentPeriodInstance]
    }

    def process = {
        def orgId = session.organization.id
        def currentPeriodInstance = Integer.parseInt(params.id)
        def acctgPeriod = AcctgPeriod.get(currentPeriodInstance)
        //To check if all previous periods are consolidated.
        def checkPrevConsol = AcctgPeriod.executeQuery("\
            FROM AcctgPeriod ap\
            WHERE ap.status = ?\
            AND ap.thruDate <= ?\
            AND ap.organization = ?\
            AND ap.id !=?\
            ORDER BY fromDate", ["Open", acctgPeriod.fromDate, session.organization, acctgPeriod.id]
        )
        if(checkPrevConsol.size()<=0) {
            //All previous period are consolidated.
            def result = glAcctgTransactionService.processConsol(currentPeriodInstance, orgId);
            def sizeResult = checkPrevConsol.size()
            def countResult = checkPrevConsol.count()
            flash.message = "${message(code: 'glAccountingTransConsolidation.consolidated', args: [message(code: 'glAccountingTransConsolidation.label', default: 'GlAccountingTransactionConsolidation'), currentPeriodInstance])}"
        }
        else{
            //There are previous period that needs consolidation
            flash.message = "${message(code: 'glAccountingTransConsolidation.error', args: [message(code: 'glAccountingTransConsolidation.label', default: 'GlAccountingTransactionConsolidation'), currentPeriodInstance])}"
        }
        
        redirect(action: "consol")
    }

}