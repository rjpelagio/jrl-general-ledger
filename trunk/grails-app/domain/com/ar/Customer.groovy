package com.ar

class Customer {

	static constraints = {
		customerCode()
		customerName()
		creditLimit()
		creditTerm()
	}

	static hasMany = [area:Area]
	
	String customerCode
	String customerName
	Integer creditLimit
	String creditTerm

}