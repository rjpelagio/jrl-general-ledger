package com.ar

class Customer {

	static constraints = {
	customerCode()
	customerName()
	creditLimit()
	creditTerm()
	}

	static hasMany = [customerArea:CustomerArea]
	String customerCode
	String customerName
	Integer creditLimit
	String creditTerm
	
<<<<<<< .mine
	 
=======
>>>>>>> .r137
}