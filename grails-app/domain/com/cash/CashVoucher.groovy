package com.cash 

import com.app.*


class CashVoucher implements Serializable {

	static auditable = true
	Date dateCreated
	String status 
	String approvalStatus
	BigDecimal total = 0.00
	BigDecimal change = 0.00
	String transType
	String cashVoucherNumber
	String referenceNumber
	String description

	static belongsTo = [preparedBy : Party, requestedBy : Party]

	static mapping = {
        preparedBy column: "preparedBy"
        requestedBy column : "requestedBy"
    }

	static constraints = {
        status (blank : false, nullable : false, inList : ['Active', 'Closed', 'Released', 'Liquidated'])
        approvalStatus (blank : false, nullable : false, inList : ['Pending Approval', 'Approved', 'Cancelled'])
        cashVoucherNumber (blank : false, nullable : false, unique : true)
    }

}