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


}


