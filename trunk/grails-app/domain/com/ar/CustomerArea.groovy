package com.ar

class CustomerArea {

    static constraints = {
		dateCreated()
	}
	
	static belongsTo = [area:Area, customer:Customer]

	Date dateCreated

}
