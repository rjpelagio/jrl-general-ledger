package com.ar

class CustomerArea {

    static constraints = {
		dateCreated()
	}

	Date dateCreated

	static mapping = {
		autoTimestamp false
	}

}