package com.app

import com.gl.GlAccountOrganization

class AppOrganization {
    
    String organizationCode
    String organizationName
    String organizationType
    String logoPath;

    static hasMany = [organization : GlAccountOrganization]

    static belongsTo = [party : Party]
    
    static constraints = {
        organizationCode (blank : false, unique : true)
        organizationName (blank : false, unique : true)
        organizationType (blank : false, inList:["Informal Organization", "Legal Organization"], unique : true)
        party (blank : false, unique : true)
        logoPath (blank : true, nullable : true)
    }
    
    String toString(){
        return "${organizationName}"
    }
    
}
