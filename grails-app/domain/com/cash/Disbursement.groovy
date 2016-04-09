package com.cash 


import com.app.*


class Disbursement {

	static auditable = true
	Date dateCreated
	String status 
	BigDecimal total = 0.00
	String disbursementNumber
	String description

	static belongsTo = [preparedBy : Party]

	static mapping = {
        preparedBy column: "preparedBy"
    }

    static constraints = {
        status (blank : false, nullable : false, inList : ['Active', 'Submitted', 'Closed', 'Released', 'Liquidated'])
    	cashVoucherNumber (blank : false, nullable : false, unique : true)
    	description (blank : false, nullable : false)
    }

    



}