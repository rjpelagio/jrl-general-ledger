package com.cash

import com.app.*

class ReplenishmentItems {
	
	static belongsTo = [replenishment : Replenishment, cashVoucher : CashVoucher, liquidation : Liquidation]

	static constraints = {
		cashVoucher (blank : true, nullable : true)
		liquidation (blank : true, nullable : true)
	}
}