package com.app

class PostalAddress {
    String address1
    String address2

    static belongsTo = [contactMech : ContactMech]
    //static belongsTo = [geo : Geo]

    static constraints = {
        address1 (blank : false)
        address2 (blank : true, nullable : true)
    }
}
