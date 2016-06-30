package com.cash

import com.app.Party

class CashHistory {
	
	
	BigDecimal amount
	Date lastUpdated
	String method

	static belongsTo = [preparedBy : Party]

	static mapping = {
        preparedBy column: "preparedBy"
    }

	static constraints = {
        method (blank : false, nullable : false, inList : ['Disbursement', 'Replenishment', 'Liquidation Change'])
    }


}