package com.gl

import com.app.*

class VoucherApproval {

	int sequence
	Date lastUpdated
	String remarks
	String position
    String status = 'Active'

	static belongsTo = [updatedBy :  Party,
            transaction : GlAccountingTransaction]

    static constraints = {
        remarks (blank : true, nullable : true, maxSize: 500)
        updatedBy (blank : true, nullable : true)
        lastUpdated (blank : true, nullable : true)
        position (blank : false, nullable : false)
        status (blank : false, nullable : false, inList : ['Active','Submitted', 'Cancelled'])
    }

    static mapping = {
        autoTimestamp false
    }

}