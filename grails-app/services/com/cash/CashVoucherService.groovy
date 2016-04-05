package com.cash

import groovy.sql.Sql
import com.gl.*
import com.app.*

class CashVoucherService {

	static transactional = true

    def dataSource

    def serviceMethod() {

    }

	def approvalService

	def validateVoucherApproval (CashVoucher trans, def session, def remarks, def transType, def formAction) {

        //Initializing remarks for new approval records, coz remarks is only available when updating
        remarks = (remarks!=null && remarks.length()>0) ? remarks : ''

        def result = CashVoucherApproval.findByTransaction(trans)
        //Check existing approval records
        if (result) {

          def approvalCriteria = CashVoucherApproval.createCriteria()

          def criteriaResult = approvalCriteria {
            and {
              eq ("position", session.employee.position)
              eq ("transaction", trans)
              eq ("status", 'Active')
            }
          }

          if (criteriaResult) {
            def approvalMap = criteriaResult.get(0)

            approvalMap.remarks = remarks
            if (remarks == '' && formAction != 'updateSubmitted') {
              approvalMap.remarks = 'Approved by ' + session.party
            }
            
            approvalMap.lastUpdated = new Date()
            approvalMap.updatedBy = session.party

            if (formAction == 'updateSubmitted') {
              approvalMap.status = 'Active'
            } else {
              approvalMap.status = 'Submitted'
            }

            approvalMap.save(flush:true)

            if (approvalMap.sequence == 1) {
              approvalService.approveTransaction(trans, transType, formAction)
            }
          }

      } else {
        //Generate approval entries if status is set to submitted and approval records does not exist
        approvalService.createApprovalEntries(transType, session, trans)
      }

    }


    def validateReimbursementItems (def params) {

        ArrayList<String> msgs = new ArrayList<String>();

        for (int i = 0; i < params.payeeIds.size(); i++) {
          if (params.payeeIds[i].isInteger()) { 
              if(!Party.get(params.payeeIds[i].toInteger())) {
                  msgs.add('Invalid Payee on row ' + (i+1))
              }
          } else {
            msgs.add('Invalid Payee on row ' + (i+1))
          }
        }

        if (params.department == 'Finance') {
          for (int i = 0; i < params.glAccountIds.size(); i++) {
            if (params.glAccountIds[i].toInteger()) {
              if(!GlAccount.get(params.glAccountIds[i].toInteger())) {
                msgs.add('Invalid GL Account on row ' + (i+1))
              } 
            } else {
              msgs.add('Invalid GL Account on row ' + (i+1))
            } 
            
          } 
        }

        return msgs;
    }


    def insertReimbursementItems (CashVoucher trans, def payeeIds, def amounts, 
        def descriptions, def refDocs, def glAccountIds, def department) {

        

        if (payeeIds.size() > 1) {

          for (int i = 0; i < payeeIds.size(); i++) { 
              def item = new CashVoucherItems();
              item.payee = Party.get(payeeIds[i]);
              item.description = descriptions[i];
              item.amount = Double.parseDouble(amounts[i]);
              item.referenceDoc = refDocs[i];
              if (department == 'Finance') {
                item.glAccount = GlAccount.get(glAccountIds[i]);
                println 'Gl Account Item : ' + item.glAccount
              }
              item.cashVoucher = trans;

              item.save(flush:true);
              if (item.hasErrors()) {
                  println item.errors
              }
          }
        } else {
          def item = new CashVoucherItems();
          item.description = descriptions
          item.referenceDoc = refDocs
          item.amount = Double.parseDouble(amounts)
          item.cashVoucher = trans
          item.payee = Party.get(payeeIds)
          if (department == 'Finance') {
            item.glAccount = GlAccount.get(glAccountIds);
            println 'Gl Account Item : ' + item.glAccount
          }
          item.save(flush:true)
          if (item.hasErrors()) {
              println item.errors
          }
        }

    }
}


