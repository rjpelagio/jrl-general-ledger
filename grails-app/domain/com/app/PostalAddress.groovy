package com.app

class PostalAddress {
    static auditable = true 
    String addressLine1
    String addressLine2
    String city
    String province
    String postalCode

    static belongsTo = [contactMech : ContactMech]
    //static belongsTo = [geo : Geo]

    static constraints = {
        addressLine1 (blank : false)
        addressLine2 (blank : true, nullable : true)
        city (blank : false)
        province (blank : false)
        postalCode (blank : false)
    }
}
