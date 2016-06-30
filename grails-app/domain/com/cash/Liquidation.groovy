package com.cash 

import com.app.*

class Liquidation {

	static auditable = true
	Date dateCreated
	String status 
	String approvalStatus
	BigDecimal total = 0.00
	BigDecimal change = 0.00
	String liquidationNumber
	String description

	static belongsTo = [preparedBy : Party, cashVoucher : CashVoucher, organization : AppOrganization]

	static mapping = {
        preparedBy column: "preparedBy"
    }

	static constraints = {
        status (blank : false, nullable : false, inList : ['Active', 'Submitted', 'Closed','Cancelled'])
        approvalStatus (blank : false, nullable : false, inList : ['Pending Approval', 'Approved', 'Denied'])
    	liquidationNumber (blank : false, nullable : false, unique : true)
    	description (blank : true, nullable : true)
    	total (blank : true, nullable : true, min : 0.01)
    }

}