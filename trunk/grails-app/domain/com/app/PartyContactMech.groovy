package com.app

class PartyContactMech {
    String purpose
    String contactMechType
    Date fromDate
    Date thruDate

    //ContactMechType Constants = POSTAL_ADDRESS, PHONE_INFO, EMAIL_ADDRESS

    static belongsTo = [party : Party,
                        contactMech : ContactMech]

    static constraints = {
        purpose (blank : true, nullable : true)
        contactMechType (blank: false, nullable : true)
        fromDate (blank : false, display : false)
        thruDate (blank : true, nullable : true, display: false)
    }
}
