package com.ar

class Area {

	String code
	String description

	static belongsTo = [customer:Customer, salesman:Salesman]

    static constraints = {
    }
}