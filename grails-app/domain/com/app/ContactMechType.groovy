package com.app

class ContactMechType {
    String contactMechType
    String description

    static constraints = {
        contactMechType (blank : false, unique : true)
        description (blank : false)
    }
}
