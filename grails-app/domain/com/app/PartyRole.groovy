package com.app

class PartyRole {
    String partyRole
    Date fromDate = new Date()
    Date thruDate
    String status

    static belongsTo = [party : Party]
    
    static constraints = {
        role (inList : ["EMPLOYEE", "ORGANIZATION", "CUSTOMER", "INTERNAL ORGANIZATION"])
        fromDate(blank : false)
        thruDate (blank : true, nullable : true)
        status (inList : ["Active", "Inactive"])
    }
}
