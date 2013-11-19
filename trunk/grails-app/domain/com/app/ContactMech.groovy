package com.app

class ContactMech {

    static belongsTo = [contactMechType : ContactMechType]

    static mapping = {
        id column: "contact_mech_id"
    }
    static constraints = {
    }
}
