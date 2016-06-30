package com.cash

import com.app.*

class ReplenishmentCashItems {
	

	int thousandDem
	int fiveHundredDem
	int twoHundredDem
	int hundredDem
	int fiftyDem
	int twentyDem
	int tenDem
	int fiveDem
	int pesoDem
	int fiftyCentDem
	int twentyFiveCentDem
	BigDecimal variance = 0.00
	BigDecimal cashOnHand = 0.00
	BigDecimal recordedCoh = 0.00

	static constraints = {
    	thousandDem (min : 0) 
		fiveHundredDem (min : 0)
		twoHundredDem (min : 0)
		hundredDem (min : 0)
		fiftyDem (min : 0)
		twentyDem (min : 0)
		tenDem (min : 0)
		fiveDem (min : 0)
		pesoDem (min : 0)
		fiftyCentDem (min : 0)
		twentyFiveCentDem (min : 0)
		cashOnHand (blank : false, nullable : false, min : 0.00)
		recordedCoh (blank : false, nullable : false, min : 0.00)
    }

	static belongsTo = [replenishment : Replenishment]

}