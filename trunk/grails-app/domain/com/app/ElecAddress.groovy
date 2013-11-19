package com.app

class ElecAddress {
    String emailString

    static belongsTo = [contactMech : ContactMech]
    
    static constraints = {
        emailString (blank : false, email : true)
    }
}
