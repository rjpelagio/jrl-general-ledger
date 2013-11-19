package com.gl

import com.app.AppOrganization;

class AcctgPreferences {
    String jvPrefix
    Integer amtRounding
    Integer priceRounding
    Integer docLineLimit
    String docFormat

    static belongsTo = [organizationCode : AppOrganization]
    
    static constraints = {
        jvPrefix (blank : false)
        amtRounding (blank : false)
        priceRounding (blank : false)
        docLineLimit (blank : false)
        docFormat (blank : false)
        organizationCode (blank : false, unique : true)
    }
}
