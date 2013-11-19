package com.app

class TeleInfo {
    String countryCode
    String areaCode
    String contactNumber
    String contactPerson
    Date dateCreated
    Date lastUpdated

    static belongsTo = [contactMech : ContactMech]
    
    static constraints = {
        countryCode (blank : false)
        areaCode (blank : false)
        contactNumber (blank : false)
        contactPerson (blank : false)
    }
}
