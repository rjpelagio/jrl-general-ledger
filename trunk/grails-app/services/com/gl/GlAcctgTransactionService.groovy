package com.gl

import com.app.*
import groovy.sql.Sql

class GlAcctgTransactionService {

    static transactional = true

    def dataSource

    def serviceMethod() {

    }
    
    def insertAcctgTrans (GlAccountingTransaction acctgTrans, 
        def glAccounts, def debits, def credits) {
        
        def seq = 1;
        
        for (int i = 0; i < glAccounts.size(); i++) {
            if((Double.parseDouble(debits[i])>0)){
                insertAcctgTransItem(glAccounts[i], debits[i],
                "Debit", seq, acctgTrans);
                seq++;
            }
        }

        for (int i = 0; i < glAccounts.size(); i++) {
            if((Double.parseDouble(credits[i])>0)){
                insertAcctgTransItem(glAccounts[i], credits[i],
                "Credit", seq, acctgTrans);
                seq++;
            }
        }
        //insertAcctgTransApproval(acctgTrans)
    }
    
    def updateAcctgTrans (GlAccountingTransaction acctgTrans, 
        def glAccounts, def debits, def credits) {
    
        def seq = 1;
        acctgTrans.entryDate = acctgTrans.transactionDate;
        acctgTrans.save()
        if (acctgTrans.hasErrors()) {
            println acctgTrans.errors
        }
        GlAccountingTransactionDetails.executeUpdate("delete \
            GlAccountingTransactionDetails items \
            WHERE items.glAccountingTransaction = ?", [acctgTrans]);
        
        for (int i = 0; i < glAccounts.size(); i++) {
            if((Double.parseDouble(debits[i])>0)){
                insertAcctgTransItem(glAccounts[i], debits[i],
                "Debit", seq, acctgTrans);
                seq++;
            }
        }

        for (int i = 0; i < glAccounts.size(); i++) {
            if((Double.parseDouble(credits[i])>0)){
                insertAcctgTransItem(glAccounts[i], credits[i],
                "Credit", seq, acctgTrans);
                seq++;
            }
        }
    }
    
    
    def insertAcctgTransItem (def glAccountId, def amount, def debitCreditFlag,
        def sequenceId, def glAcctgTrans) {
        //println('GL : ' + glAccountId)
        def acctgTransItem = new GlAccountingTransactionDetails();
        def glAcctOrg = GlAccountOrganization.get(glAccountId);
        acctgTransItem.sequenceId = sequenceId;
        acctgTransItem.glAccount = GlAccount.get(glAcctOrg.glAccount.id);
        acctgTransItem.amount = Double.parseDouble(amount);
        acctgTransItem.debitCreditFlag = debitCreditFlag;
        acctgTransItem.glAccountingTransaction = glAcctgTrans;
        acctgTransItem.save();
        if (acctgTransItem.hasErrors()) {
            println acctgTransItem.errors
        }
    }

    def insertAcctgTransApproval (GlAccountingTransaction glAcctgTrans, def department, AppUser loggedUser) {
        def approvalFeature = Approval.findByDepartmentAndApprovalFeature(department, 'VOUCHER')
        def approvalSeq = ApprovalSeq.findAllByApproval(approvalFeature)
        for (int a=0; a<3; a++) {
            def acctgTransApproval = new AcctgTransApproval()
            acctgTransApproval.acctgTrans = glAcctgTrans
            acctgTransApproval.approvalSeq = ApprovalSeq.get(approvalSeq[a].id)
            if(approvalSeq[a].sequence==1){
                acctgTransApproval.user = loggedUser
            }
            acctgTransApproval.save()
            if(acctgTransApproval.hasErrors()){
                println acctgTransApproval.errors
            }
        }
    }

    def checkApproval (def transactionType, def department){
        def approvalFeature = Approval.findByDepartmentAndApprovalFeature(department, transactionType)
        def approvalStatus = 0
        if (approvalFeature){
            def approvalSeq = ApprovalSeq.findAllByApproval(approvalFeature)
            if(approvalFeature.count() > 0) {
                approvalStatus = 1
            }
        }
        //println 'Approval Feature: ' + approvalFeature.count()
        //println 'Approval Seq: ' + approvalSeq.size()
        
        return approvalStatus
    }

    def consolResult(def currentPeriod, def orgId) {

        def db = new Sql(dataSource)
        String organizationId = orgId //The logged company
        def period = currentPeriod //The selected period
        //println "Service Param Period: " + currentPeriod
        def prevPeriod = 0
        //println "Service Period: " + (currentPeriod - 1)
        if (currentPeriod)
        {
            prevPeriod = (currentPeriod - 1) //The previous period before the selected period for consolidation
        }
        else
        {
            prevPeriod = 0
        }

        //println "Service Previous: " + prevPeriod
        String transFromDate = AcctgPeriod.get(currentPeriod).fromDate //The transaction date to be used for the computation of debit and credit total amount
        String transThruDate = AcctgPeriod.get(currentPeriod).thruDate //The transaction date to be used for the computation of debit and credit total amount

        def result = db.rows("\
            SELECT id, main_acct, main_desc, IFNULL(beg_bal, 0) as beg_bal, dr_main_amount, cr_main_amount, debit_amount, credit_amount,\
                    (IFNULL(beg_bal, 0) + IFNULL(debit_amount, 0) - IFNULL(credit_amount, 0)) as end_bal,\
                    CASE WHEN gl_account=main_acct\
                    THEN ''\
                    ELSE gl_account\
                    END as gl_account,\
                    CASE WHEN gl_account=main_acct\
                    THEN ''\
                    ELSE description\
                    END as description\
            FROM\
              (SELECT id, IFNULL(main_acct, gl_account) as main_acct, IFNULL(main_desc, description) as main_desc,\
                      gl_account, description,\
                      (IFNULL(dr_main_amount, 0) + (IFNULL(debit_amount, 0))) as debit_amount,\
                      (IFNULL(cr_main_amount, 0) + (IFNULL(credit_amount, 0))) as credit_amount, IFNULL(dr_main_amount, 0) as dr_main_amount, IFNULL(cr_main_amount, 0) as cr_main_amount,\
                      dr_acct, parent_gl_account_id\
              FROM\
                (SELECT id, main_acct, main_desc, gl_account, description, debit_amount, credit_amount, IFNULL(dr_main_amount, 0) as dr_main_amount, dr_acct, parent_gl_account_id\
                FROM\
                  (SELECT id, main_acct, main_desc, gl_account, description, debit_amount, credit_amount\
                  FROM\
                    (SELECT gl_account.id, gl_account, description, main_acct, main_desc, det1.*\
                    FROM\
                      (SELECT gl_accounts.id, gl_account_type_id, main_acct, main_desc, gl_account, description, gl_account_organization.organization_id\
                      FROM\
                        (SELECT gl1.id, gl1.gl_account_type_id, gl2.gl_account as main_acct, gl2.description as main_desc, gl1.gl_account as gl_account, gl1.description as description\
                        FROM gl_account as gl1\
                        LEFT JOIN gl_account as gl2\
                        ON gl1.parent_gl_account_id=gl2.id) as gl_accounts\
                      INNER JOIN gl_account_organization\
                      ON gl_accounts.id = gl_account_organization.gl_account_id\
                      WHERE organization_id = " + organizationId +") as gl_account\
                    LEFT JOIN\
                      (SELECT SUM(amount) as debit_amount, gl_account_id as debit_acct\
                      FROM gl_accounting_transaction_details\
                      WHERE debit_credit_flag = 'Debit' and gl_accounting_transaction_id IN\
                        (SELECT id\
                        FROM gl_accounting_transaction\
                        WHERE transaction_date between '"+ transFromDate +"' and '" + transThruDate + "')\
                      GROUP BY gl_account_id) as det1\
                    ON gl_account.id = det1.debit_acct) as det\
                  LEFT JOIN\
                    (SELECT SUM(amount) as credit_amount, gl_account_id as credit_acct\
                    FROM gl_accounting_transaction_details\
                    WHERE debit_credit_flag = 'Credit' and gl_accounting_transaction_id IN\
                      (SELECT id\
                      FROM gl_accounting_transaction\
                      WHERE transaction_date between '"+ transFromDate +"' and '" + transThruDate + "')\
                      GROUP BY gl_account_id) as det2\
                  ON det.id = det2.credit_acct) as transdet\
                LEFT JOIN\
                  (SELECT SUM(dr_main_amount) as dr_main_amount, dr_acct, parent_gl_account_id\
                  FROM gl_account\
                  LEFT JOIN\
                  (SELECT SUM(amount) as dr_main_amount, gl_account_id as dr_acct\
                  FROM gl_accounting_transaction_details\
                  WHERE debit_credit_flag = 'Debit' and gl_accounting_transaction_id IN\
                    (SELECT id\
                    FROM gl_accounting_transaction\
                    WHERE transaction_date between '"+ transFromDate +"' and '" + transThruDate + "')\
                  GROUP BY gl_account_id) as dr_main_det\
                  ON gl_account.id=dr_acct\
                  GROUP BY parent_gl_account_id) as dr_main_consol\
                ON dr_main_consol.parent_gl_account_id=transdet.id) as dr_consol\
              LEFT JOIN\
                (SELECT SUM(cr_main_amount) as cr_main_amount, cr_acct, parent_gl_account_id as cr_main_acct_id\
                FROM gl_account\
                LEFT JOIN\
                (SELECT SUM(amount) as cr_main_amount, gl_account_id as cr_acct\
                FROM gl_accounting_transaction_details\
                WHERE debit_credit_flag = 'Credit' and gl_accounting_transaction_id IN\
                  (SELECT id\
                  FROM gl_accounting_transaction\
                  WHERE transaction_date between '"+ transFromDate +"' and '" + transThruDate + "')\
                GROUP BY gl_account_id) as cr_main_det\
                ON gl_account.id=cr_acct\
                GROUP BY cr_main_acct_id) as cr_main_consol\
              ON cr_main_consol.cr_main_acct_id=dr_consol.id) as consol\
            LEFT JOIN\
              (SELECT gl_account_id, (IFNULL(balance, 0))as beg_bal\
               FROM gl_account_org_bal\
               WHERE organization_id = " + organizationId +" and acctg_period_id = "+ prevPeriod +") as org_bal\
            ON org_bal.gl_account_id = consol.id")
        return result;
    }

    def processConsol (Object currentPeriod, Object orgId){
        //Dapat ipasa yung selected period.
        def db = new Sql(dataSource)
        
        String organizationId = orgId //The logged company
        Integer period = currentPeriod //The selected period

        Integer prevPeriod = period - 1 //The previous period before the selected period for consolidation
        if(currentPeriod < 1)
        {
            prevPeriod = "0"
        }
        String transFromDate = AcctgPeriod.get(currentPeriod).fromDate //The transaction date to be used for the computation of debit and credit total amount
        String transThruDate = AcctgPeriod.get(currentPeriod).thruDate //The transaction date to be used for the computation of debit and credit total amount
        //println 'Current Period: ' + period
        //Dapat iinsert nya lahat basta open pa yung period at lahat ay posted ang transactions
        //Then icclose na yung period na sinelect
        db.execute("\
            INSERT INTO gl_account_org_bal (acctg_period_id, balance, gl_account_id, organization_id, version)\
            SELECT '"+ period +"',\
                    (IFNULL(beg_bal, 0) + IFNULL(debit_amount, 0) - IFNULL(credit_amount, 0)) as end_bal,\
                    id, '"+ organizationId +"', 1\
            FROM\
              (SELECT id, IFNULL(main_acct, gl_account) as main_acct, IFNULL(main_desc, description) as main_desc,\
                      gl_account, description,\
                      (IFNULL(dr_main_amount, 0) + (IFNULL(debit_amount, 0))) as debit_amount,\
                      (IFNULL(cr_main_amount, 0) + (IFNULL(credit_amount, 0))) as credit_amount, IFNULL(dr_main_amount, 0) as dr_main_amount, IFNULL(cr_main_amount, 0) as cr_main_amount,\
                      dr_acct, parent_gl_account_id\
              FROM\
                (SELECT id, main_acct, main_desc, gl_account, description, debit_amount, credit_amount, IFNULL(dr_main_amount, 0) as dr_main_amount, dr_acct, parent_gl_account_id\
                FROM\
                  (SELECT id, main_acct, main_desc, gl_account, description, debit_amount, credit_amount\
                  FROM\
                    (SELECT gl_account.id, gl_account, description, main_acct, main_desc, det1.*\
                    FROM\
                      (SELECT gl_accounts.id, gl_account_type_id, main_acct, main_desc, gl_account, description, gl_account_organization.organization_id\
                      FROM\
                        (SELECT gl1.id, gl1.gl_account_type_id, gl2.gl_account as main_acct, gl2.description as main_desc, gl1.gl_account as gl_account, gl1.description as description\
                        FROM gl_account as gl1\
                        LEFT JOIN gl_account as gl2\
                        ON gl1.parent_gl_account_id=gl2.id) as gl_accounts\
                      INNER JOIN gl_account_organization\
                      ON gl_accounts.id = gl_account_organization.gl_account_id\
                      WHERE organization_id = " + organizationId +") as gl_account\
                    LEFT JOIN\
                      (SELECT SUM(amount) as debit_amount, gl_account_id as debit_acct\
                      FROM gl_accounting_transaction_details\
                      WHERE debit_credit_flag = 'Debit' and gl_accounting_transaction_id IN\
                        (SELECT id\
                        FROM gl_accounting_transaction\
                        WHERE transaction_date between '"+ transFromDate +"' and '" + transThruDate + "')\
                      GROUP BY gl_account_id) as det1\
                    ON gl_account.id = det1.debit_acct) as det\
                  LEFT JOIN\
                    (SELECT SUM(amount) as credit_amount, gl_account_id as credit_acct\
                    FROM gl_accounting_transaction_details\
                    WHERE debit_credit_flag = 'Credit' and gl_accounting_transaction_id IN\
                      (SELECT id\
                      FROM gl_accounting_transaction\
                      WHERE transaction_date between '"+ transFromDate +"' and '" + transThruDate + "')\
                      GROUP BY gl_account_id) as det2\
                  ON det.id = det2.credit_acct) as transdet\
                LEFT JOIN\
                  (SELECT SUM(dr_main_amount) as dr_main_amount, dr_acct, parent_gl_account_id\
                  FROM gl_account\
                  LEFT JOIN\
                  (SELECT SUM(amount) as dr_main_amount, gl_account_id as dr_acct\
                  FROM gl_accounting_transaction_details\
                  WHERE debit_credit_flag = 'Debit' and gl_accounting_transaction_id IN\
                    (SELECT id\
                    FROM gl_accounting_transaction\
                    WHERE transaction_date between '"+ transFromDate +"' and '" + transThruDate + "')\
                  GROUP BY gl_account_id) as dr_main_det\
                  ON gl_account.id=dr_acct\
                  GROUP BY parent_gl_account_id) as dr_main_consol\
                ON dr_main_consol.parent_gl_account_id=transdet.id) as dr_consol\
              LEFT JOIN\
                (SELECT SUM(cr_main_amount) as cr_main_amount, cr_acct, parent_gl_account_id as cr_main_acct_id\
                FROM gl_account\
                LEFT JOIN\
                (SELECT SUM(amount) as cr_main_amount, gl_account_id as cr_acct\
                FROM gl_accounting_transaction_details\
                WHERE debit_credit_flag = 'Credit' and gl_accounting_transaction_id IN\
                  (SELECT id\
                  FROM gl_accounting_transaction\
                  WHERE transaction_date between '"+ transFromDate +"' and '" + transThruDate + "')\
                GROUP BY gl_account_id) as cr_main_det\
                ON gl_account.id=cr_acct\
                GROUP BY cr_main_acct_id) as cr_main_consol\
              ON cr_main_consol.cr_main_acct_id=dr_consol.id) as consol\
            LEFT JOIN\
              (SELECT gl_account_id, (IFNULL(balance, 0))as beg_bal\
               FROM gl_account_org_bal\
               WHERE organization_id = " + organizationId +" and acctg_period_id = "+ prevPeriod +") as org_bal\
            ON org_bal.gl_account_id = consol.id");


        db.execute("Update acctg_period SET status='Close' WHERE id=?", [currentPeriod])
    }

    def approve (def transId) {
        def db = new Sql(dataSource)

        db.execute("UPDATE gl_accounting_transaction SET status='Approved', posted_date=? WHERE id=?", [new Date(), transId])
    }

    def cancel (def transId) {
        def db = new Sql(dataSource)

        db.execute("UPDATE gl_accounting_transaction SET status='Cancelled' WHERE id=?", [transId])
    }

    def submit (def transId) {
        def db = new Sql(dataSource)

        db.execute("UPDATE gl_accounting_transaction SET status='For Approval' WHERE id=?", [transId])
    }


     

    
}
