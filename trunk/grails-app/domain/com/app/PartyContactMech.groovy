package com.app

class PartyContactMech {
    String purpose
    Date fromDate
    Date thruDate

    static belongsTo = [party : Party,
                        contactMech : ContactMech]

    static constraints = {
        purpose (blank : true, nullable : true)
        fromDate (blank : false, display : false)
        thruDate (blank : true, nullable : true, display: false)
    }
}
