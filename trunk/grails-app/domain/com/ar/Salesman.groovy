package com.ar

class Salesman {

	static constraints = {
		agentCode()
		lastName(blank:false, maxSize:50)
		firstName(blank:false, maxSize:50)
	}

	String agentCode
	String lastName
	String firstName
	
}