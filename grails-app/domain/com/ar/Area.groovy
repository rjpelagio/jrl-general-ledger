package com.ar

class Area {


	static constraints = {

	code (blank : false)
	description(blank : false)

	 }

	 static hasMany = [customerArea:CustomerArea]


	String code
	String description
		

}
