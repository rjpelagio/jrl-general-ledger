package com.gl

import com.app.AppOrganization


class GlAccountOrganization {
    
    Date startDate = new Date()
    Date thruDate
    
    static belongsTo = [glAccount : GlAccount,
                organization: AppOrganization]
    
    static constraints = {
        glAccount (blank : false)
        organization (blank : false)
        startDate (blank : false, display : false)
        thruDate (blank : false, nullable : true, display : false)
    }

     String toString(){
        return "${GlAccount.find(glAccount).glAccount} -- ${GlAccount.find(glAccount).description}"
    }
}
