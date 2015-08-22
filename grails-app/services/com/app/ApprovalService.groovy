	package com.app

import groovy.sql.Sql
import com.gl.*

class ApprovalService {

	static transactional = true

    def dataSource

    def serviceMethod() {

    }

    def checkApproval (def department, def position){

    	def approvalStatus = false

        def approvalFeature = Approval.createCriteria()

        def result = approvalFeature {
          and {
            eq ("position", position)
            eq ("department", department)
            eq ("approvalFeature", "VOUCHER")
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

    def validateVoucherApproval (GlAccountingTransaction trans, def session, def remarks, def transType) {

    	//Initializing remarks for new approval records, coz remarks is only available when updating
    	remarks = (remarks!=null && remarks.length()>0) ? remarks : ''

    	println 'TRANS TRANS TRANS : ' + trans

    	def result = VoucherApproval.findByTransaction(trans)
		//Check existing approval records
    	if (result) {

    		def approvalCriteria = VoucherApproval.createCriteria()

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
    			if (remarks == '') {
    				approvalMap.remarks = 'Approved by ' + session.party
    			}
    			approvalMap.lastUpdated = new Date()
    			approvalMap.updatedBy = session.party
    			approvalMap.status = 'Submitted'
    			approvalMap.save(flush:true)

    			if (approvalMap.sequence == 1) {
    				approveTransaction(trans, transType)
    			}
      		}

		} else {
            //Generate approval entries if status is set to submitted and approval records does not exist
			createApprovalEntries(transType, session, trans)
    	}
    }

    def createApprovalEntries (def transType, def session, def transaction) {

    	switch(transType) {
    		case 'voucher' : createVoucherApproval(session, transaction)
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

    def approveTransaction (def trans, def transType) {

    	//This will close the transaction when the final approver submits it
    	switch(transType) {
    		case 'voucher' : def transaction = GlAccountingTransaction.get(trans.id)
    						 if (transaction) {
    						 	println 'VOUCHER NO : ' + transaction.voucherNo
    						 	transaction.approvalStatus = 'Approved'
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

    			if (session.employee.position == map.position && map.sequence == 1) {
					approveTransaction (map.transaction, 'voucher') 
				}
			}
    	}
    }


    





}