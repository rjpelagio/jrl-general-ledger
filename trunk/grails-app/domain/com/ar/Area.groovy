package com.ar

class Area {

	String code
	String description

	static hasMany = [customerArea:CustomerArea, salesmanArea:SalesmanArea]

    static constraints = {
    }
}