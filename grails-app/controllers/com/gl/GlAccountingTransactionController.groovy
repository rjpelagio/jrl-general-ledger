package com.gl

import grails.converters.deep.JSON
import com.app.*
import groovy.sql.Sql

class GlAccountingTransactionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def beforeInterceptor = [action:this.&auth]
    
    def glSearchService;
    def glAcctgTransactionService;

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

        [glAccountingTransactionInstanceList: result.subList(offset, toIndex), glAccountingTransactionInstanceTotal: result.size(), glAccountingTransactionInstance: glAccountingTransactionInstance, offset : toIndex]
    }

    def create = {
        def glAccountingTransactionInstance = new GlAccountingTransaction()
        glAccountingTransactionInstance.properties = params
        def glAccounts = [:];
        def debit = 0.00;
        def credit = 0.00;
        def disableFields = false;
        
        def approvalStatus = glAcctgTransactionService.checkApproval('Voucher', session.employee.department)
        println "ApprovalStatus " + approvalStatus
        if (approvalStatus == false) { 
            flash.errors = "${message(code : 'approval.notFound')}"
            disableFields = true;
        }


        return [glAccountingTransactionInstance: glAccountingTransactionInstance, 
            glAccounts : glAccounts,
            debit : debit,
            credit : credit,
            disableFields : disableFields]
    }

    def submit = {
            glAcctgTransactionService.submit(params.id)
            flash.message = "${message(code: 'glAccountingTransaction.submitted', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
            redirect(action: "show", id: params.id)
    }
    
    def save = {
        def glAccountingTransactionInstance = new GlAccountingTransaction(params)
        def newParty = Party.get(params.party)
        glAccountingTransactionInstance.organization = session.organization
        glAccountingTransactionInstance.entryDate = new Date()
        glAccountingTransactionInstance.party = Party.get(params.partyId)
        if(params.create=="Submit"){
            glAccountingTransactionInstance.status = "For Approval"
        }else{
            glAccountingTransactionInstance.status = "Active"
        }
        //Parameters
        def glAccounts = params.glAccounts;
        def glAccountIds = params.glAccountIds;
        def debits = params.debits;
        def credits = params.credits;
        def debit = params.debit;
        def credit = params.credit;

        def approvalStatus = glAcctgTransactionService.checkApproval('Voucher', session.employee.department)

        if(Double.parseDouble(debit)<=0 || Double.parseDouble(credit)<=0 || Double.parseDouble(credit)!=Double.parseDouble(debit) || approvalStatus==0) {
            //GL Account List
            def glAccountList = [:];
            glAccountList = GlAccountOrganization.executeQuery("\
                FROM GlAccountOrganization org\
                WHERE org.organization LIKE ?\
                ", [session.organization]);
            if(Double.parseDouble(debit)<=0 || Double.parseDouble(credit)<=0 || Double.parseDouble(credit)!=Double.parseDouble(debit)){
                flash.message = "Debit and Credit values are not equal.";
            }
            if(approvalStatus==0){
                flash.message = "${message(code: 'glAccountingTransaction.noApproval', args: ['Voucher', session.employee.department])}"
            }
            
            render(view: "create", model: [glAccountingTransactionInstance: glAccountingTransactionInstance, 
                glAccountList : glAccountList, 
                glAccounts : glAccounts,
                debits : debits,
                credits : credits,
                debit : debit,
                credit : credit]
            )
        } else {
            glAccountingTransactionInstance.entryDate = glAccountingTransactionInstance.transactionDate;
            //glAccountingTransactionInstance.status = "Active"
            glAccountingTransactionInstance.save()
            if (glAccountingTransactionInstance.hasErrors()) {
                //GL Account List
                def glAccountList = [:];
                glAccountList = GlAccountOrganization.executeQuery("\
                    FROM GlAccountOrganization org\
                    WHERE org.organization LIKE ?\
                    ", [session.organization]);
                
                render(view: "create", model: [glAccountingTransactionInstance: glAccountingTransactionInstance, 
                glAccountList : glAccountList, 
                glAccounts : glAccounts,
                debits : debits,
                credits : credits,
                debit : debit,
                credit : credit])
            } else {
            
                //Data Entry
                //glAccountingTransactionInstance.save()
                glAcctgTransactionService.insertAcctgTrans(
                    glAccountingTransactionInstance,
                    glAccounts,
                    debits,
                    credits
                )
                glAcctgTransactionService.insertAcctgTransApproval(glAccountingTransactionInstance, session.employee.department, session.user)
                if(params.create=="Submit"){
                    flash.message = "${message(code: 'glAccountingTransaction.submitted', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
                }else{
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), glAccountingTransactionInstance.id])}"
                }
                redirect(action: "show", id: glAccountingTransactionInstance.id)
            }
            
        }
    }

    def show = {
        def glAccountingTransactionInstance = GlAccountingTransaction.get(params.id)
        def db = new Sql(dataSource)
        if (!glAccountingTransactionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
            redirect(action: "list")
        }
        else {
            //retrieve acctg trans items
            def transItems = GlAccountingTransactionDetails.findAllByGlAccountingTransaction(glAccountingTransactionInstance);
            def transApproval = AcctgTransApproval.findAllByAcctgTrans(glAccountingTransactionInstance);
            def approvalSeq = AcctgTransApproval.findAllByAcctgTrans(glAccountingTransactionInstance);
            def approverChecker = db.firstRow("SELECT approval_seq.role_id as role\
                FROM gl_accounting_transaction as trans\
                LEFT JOIN acctg_trans_approval as approval\
                ON trans.id = approval.acctg_trans_id\
                INNER JOIN approval_seq\
                ON approval_seq.id=approval.approval_seq_id\
                WHERE acctg_trans_id=? and user_id IS NULL ORDER BY sequence", [params.id])
            def appRole = null
            if(approverChecker){
                appRole = AppRole.get(approverChecker.role)
            }
            [glAccountingTransactionInstance: glAccountingTransactionInstance, transItems : transItems, transApproval : transApproval, approverChecker : approverChecker]
        }
    }

    def edit = {
        def glAccountingTransactionInstance = GlAccountingTransaction.get(params.id)
        if (!glAccountingTransactionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
            redirect(action: "list")
        }
        else {
            def transItems = GlAccountingTransactionDetails.findAllByGlAccountingTransaction(glAccountingTransactionInstance);
            def glAccounts = [];
            def debits = [];
            def credits = [];
            def credit = 0;
            def debit = 0;
            for(int i = 0; i < transItems.size(); i++){
                def acctOrg = GlAccountOrganization.findByGlAccountAndOrganization(transItems[i].glAccount, session.organization);
                glAccounts.add(acctOrg);
                if (transItems[i].debitCreditFlag.equalsIgnoreCase("Debit")){
                    debits.add(transItems[i].amount);
                    debit = debit + transItems[i].amount
                    credits.add(0)
                } else if (transItems[i].debitCreditFlag.equalsIgnoreCase("Credit")){
                    debits.add(0);
                    credits.add(transItems[i].amount)
                    credit = credit + transItems[i].amount
                }
            }

            def glAccountList = [:];
            def glAccountItems = [];
            def amounts = [];
            def debitCreditFlags = [];
            glAccountList = GlAccountOrganization.executeQuery("\
                FROM GlAccountOrganization org\
                WHERE org.organization LIKE ?\
                ", [session.organization]);
            [glAccountingTransactionInstance: glAccountingTransactionInstance, 
                transItems : transItems,
                glAccountList : glAccountList,
                glAccounts : glAccounts,
                glAccountItems : glAccountItems,
                debits : debits,
                credits : credits,
                debit : debit,
                credit : credit
                ]
        }
    }
    
    def update = {
        def glAccountingTransactionInstance = GlAccountingTransaction.get(params.id)
        def glAccountItems = params.glAccounts;
        def debits = params.debits;
        def credits = params.credits;
        def debit = params.debit;
        def credit = params.credit;
        def glAccountList = [:];
        def transItems = [:];
        glAccountList = GlAccountOrganization.executeQuery("\
            FROM GlAccountOrganization org\
            WHERE org.organization LIKE ?\
            ", [session.organization]); 
        
        if (glAccountingTransactionInstance) {
            if (params.debit != params.credit) {
                
                flash.message = "Debit and Credit values are not equal.";
                render(view: "edit", model: [glAccountingTransactionInstance: glAccountingTransactionInstance, 
                    glAccountList : glAccountList, 
                    glAccountItems : glAccountItems,
                    debits : debits,
                    credits : credits,
                    debit : params.debit,
                    credit : params.credit,
                    transItems : transItems])
            
            } else {
                if (params.version) {
                    def version = params.version.toLong()
                    if (glAccountingTransactionInstance.version > version) {
                        glAccountingTransactionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction')] as Object[], "Another user has updated this GlAccountingTransaction while you were editing")
                        render(view: "edit", model: [glAccountingTransactionInstance: glAccountingTransactionInstance, 
                            glAccountList : glAccountList, 
                            glAccountItems : glAccountItems,
                            credits : credits,
                            debits : debits,
                            debit : params.debit,
                            credit : params.credit,
                            transItems : transItems])
                        return
                    }
                }
                //Do the updating
                if(params.update=="Submit"){
                    glAccountingTransactionInstance.status = "For Approval"
                }else{
                    glAccountingTransactionInstance.status = "Active"
                }
                glAccountingTransactionInstance.properties = params
                glAcctgTransactionService.updateAcctgTrans(
                    glAccountingTransactionInstance,
                    glAccountItems,
                    debits,
                    credits
                )
                if(params.update=="Submit"){
                    flash.message = "${message(code: 'glAccountingTransaction.submitted', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
                }else{
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), glAccountingTransactionInstance.id])}"
                }
                redirect(action: "show", id: glAccountingTransactionInstance.id)
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
            redirect(action: "list")
        }
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

    def cancel = {
        glAcctgTransactionService.cancel(params.id)
        flash.message = "${message(code: 'glAccountingTransaction.cancelled', args: [message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction'), params.id])}"
        redirect(action: "show", id: params.id)
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