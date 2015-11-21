package com.app

class ElecAddress {
	static auditable = true
    String emailString

    static belongsTo = [contactMech : ContactMech]
    
    static constraints = {
        emailString (blank : false, email : true)
    }
}
