package com.ar

class Customer {

	static constraints = {

	customerCode(blank : false)
	customerName(blank : false)
	creditLimit(blank : false)
	creditTerm(blank : false)
	
	}

	static hasMany = [customerArea:CustomerArea]
	String customerCode
	String customerName
	Integer creditLimit
	String creditTerm
	

}