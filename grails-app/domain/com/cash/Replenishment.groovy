package com.cash

import com.app.*
import com.gl.GlAccount

class Replenishment {
	
	static auditable = true
	Date dateCreated
	String status
	String approvalStatus
	BigDecimal amount = 0.00
	BigDecimal change = 0.00
	String replenishmentNumber
	String description


	static belongsTo = [preparedBy : Party, glAccount : GlAccount, organization : AppOrganization]

	static mapping = {
        preparedBy column: "preparedBy"
    }

    static constraints = {
        status (blank : false, nullable : false, inList : ['Active', 'Submitted', 'Closed', 'Cancelled'])
        approvalStatus (blank : false, nullable : false, inList : ['Pending Approval', 'Approved', 'Denied'])
    	replenishmentNumber (blank : false, nullable : false, unique : true)
    	description (blank : true, nullable : true)
    	amount (blank : false, nullable : false, min : 0.01)
    	change (blank : true, nullable : true, min : 0.00)
    }



}