package com.app

class ContactMech {

	static auditable = true
    String contactMechType;

    static mapping = {
        id column: "contact_mech_id"
    }
    static constraints = {
    	contactMechType (blank: false, nullable : true)
    }
}
