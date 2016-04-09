package com.cash 


import com.app.*


class DisbursementItems {

	BigDecimal total = 0.00
	String remarks

	static belongsTo = [disbursement : Disbursement, cashVoucher : CashVoucher]


    static constraints = {
    	remarks (blank : true, nullable : true)
    }
    
}