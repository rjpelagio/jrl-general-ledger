package com.app

class PartyRole {
    AppRole role
    Date fromDate = new Date()
    Date thruDate
    String status

    static belongsTo = [party : Party]

    static mapping = {
        role column: "role_id"
    }
    
    static constraints = {
        fromDate(blank : false)
        thruDate (blank : true, nullable : true)
        status (inList : ["Active", "Inactive"])
    }
}
