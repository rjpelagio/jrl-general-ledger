package com.cash

import com.app.Party


class CashVoucherApproval implements Serializable {

	int sequence
	Date lastUpdated
	String remarks
	String position
    String status = 'Active'
    String transType

	static belongsTo = [updatedBy :  Party,
            transaction : CashVoucher]

    static constraints = {
        remarks (blank : true, nullable : true, maxSize: 500)
        updatedBy (blank : true, nullable : true)
        lastUpdated (blank : true, nullable : true)
        position (blank : false, nullable : false)
        status (blank : false, nullable : false, inList : ['Active','Submitted', 'Cancelled'])
        transType (blank: false, nullable : false, inList : ['CASH_ADVANCE', 'REIMBURSEMENT'])
    }

    static mapping = {
        autoTimestamp false
    }

}