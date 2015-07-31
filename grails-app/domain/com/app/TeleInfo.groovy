package com.app

class TeleInfo {
    static auditable = true
    String areaCode
    String contactNumber
    String mobileNumber
    String contactPerson
    Date dateCreated
    Date lastUpdated

    static belongsTo = [contactMech : ContactMech]
    
    static constraints = {
        areaCode (blank : false)
        contactNumber (blank : false)
        contactPerson (blank : false)
        mobileNumber (blank : false)
    }
}
