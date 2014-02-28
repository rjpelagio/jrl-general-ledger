package com.app

class PartyRole {
    String role
    Date fromDate = new Date()
    Date thruDate
    String status

    static belongsTo = [party : Party]
    
    static constraints = {
        role (inList : ["Employee", "Customer", "Supplier", "Organization"])
        fromDate(blank : false)
        thruDate (blank : true, nullable : true)
        status (inList : ["Active", "Inactive"])
    }
}
