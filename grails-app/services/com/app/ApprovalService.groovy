package com.app

import groovy.sql.Sql
import com.gl.*
import com.cash.*

class ApprovalService {

	static transactional = true

    def dataSource

    def serviceMethod() {

    }

    def checkApproval (def department, def position, def feature){

    	def approvalStatus = false

        def approvalFeature = Approval.createCriteria()

        def result = approvalFeature {
          and {
            eq ("position", position)
            eq ("department", department)
            eq ("approvalFeature", feature)
          }
        }

        if (result.size() > 0){
            def approvalSeq = ApprovalSeq.findByApproval(result.get(0))
            if(approvalSeq.count() > 0) {
                approvalStatus = true
            } 
        }

        return approvalStatus

    }

    def createApprovalEntries (def transType, def session, def transaction) {

    	switch(transType) {
    		case 'voucher' : createVoucherApproval(session, transaction)
    						break;
            case 'cash_advance' : createCashVoucherApproval(session, transaction)
                            break;
    		default : break; 
    	}
    }

    def retrieveApprovalTemplate (def department, def position, def form) {

    	def approvalFeature = Approval.createCriteria()

        def template = approvalFeature {
          and {
            eq ("position", position)
            eq ("department", department)
            eq ("approvalFeature", form)
          }
        }

    	if (template.size() > 0){
    		//If template found, get ApprovalItems
    		def result = ApprovalSeq.findAllByApproval(template.get(0))
    		if (result) {
    			return result
    		} else {
    			return null
    		}
    	} else {
    		return null
    	}
    }

    def approveTransaction (def trans, def transType, def formAction) {

    	//This will close the transaction when the final approver submits it
    	switch(transType) {
    		case 'voucher' : def transaction = GlAccountingTransaction.get(trans.id)
    						 if (transaction) {
                                if (formAction != 'updateSubmitted') {
    						 	    transaction.approvalStatus = 'Approved'
                                }
    						 	transaction.save(flush:true)
    						 }
    						 def result = VoucherApproval.findAllByTransaction(trans)
    						 if (result) {
    						 	for (int i = 0; i < result.size(); i++) {
    						 		if (result.get(i).remarks == '') {
    						 			result.get(i).remarks = 'No remarks.'
    						 			result.get(i).save(flush:true)
    						 		}
    						 	}
    						 }
    						 break;
            case 'cash_advance' : def transaction = CashVoucher.get(trans.id)
                             if (transaction) {
                                if (formAction != 'updateSubmitted') {
                                    transaction.approvalStatus = 'Approved'
                                }
                                transaction.save(flush:true)
                             }
                             def result = CashVoucherApproval.findAllByTransaction(trans)
                             if (result) {
                                for (int i = 0; i < result.size(); i++) {
                                    if (result.get(i).remarks == '') {
                                        result.get(i).remarks = 'No remarks.'
                                        result.get(i).save(flush:true)
                                    }
                                }
                             }
                             break;
    		default : break; 
    	}
    }
  
    def createVoucherApproval (def session, def transaction) {

    	//Retrive Approval Template
    	def result = retrieveApprovalTemplate(session.employee.department, session.employee.position, 'voucher')

    	def map; 
    	if (result) {
    		for (int i = 0; i < result.size(); i++) {
    			map = new VoucherApproval();
    			map.transaction = transaction
    			map.sequence = result.get(i).sequence
    			map.position = result.get(i).position
    			if (result.get(i).position == session.employee.position) {
    				map.updatedBy = session.party
    				map.lastUpdated = new Date()
    				map.remarks = 'Prepared and submitted by ' + session.party.name
    				map.status = 'Submitted'
	    		} else {
    				map.remarks = ''
    				map.status = 'Active'
    				map.lastUpdated = null
    			}

    			map.save(flush:true)

                def formAction = 'save'
    			if (session.employee.position == map.position && map.sequence == 1) {
					approveTransaction (map.transaction, 'voucher', formAction) 
				}
			}
    	}
    }

    def createCashVoucherApproval (def session, def transaction) {

        //Retrive Approval Template
        def result = retrieveApprovalTemplate(session.employee.department, session.employee.position, 'cash_advance')

        def map; 
        if (result) {
            for (int i = 0; i < result.size(); i++) {
                map = new CashVoucherApproval();
                map.transaction = transaction
                map.sequence = result.get(i).sequence
                map.position = result.get(i).position
                map.transType = 'CASH_ADVANCE'
                if (result.get(i).position == session.employee.position) {
                    map.updatedBy = session.party
                    map.lastUpdated = new Date()
                    map.remarks = 'Prepared and submitted by ' + session.party.name
                    map.status = 'Submitted'
                } else {
                    map.remarks = ''
                    map.status = 'Active'
                    map.lastUpdated = null
                }

                map.save(flush:true)
                if (map.hasErrors()) {
                    map.printErrors
                }

                def formAction = "save"
                if (session.employee.position == map.position && map.sequence == 1) {
                    approveTransaction (map.transaction, 'cash_advance', formAction) 
                }
            }
        }
    }


    





}