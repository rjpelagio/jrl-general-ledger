package com.gl

class PeriodType {    
    String periodTypeId
    String periodName
    Date dateCreated
    Date lastUpdated

    static constraints = {
        periodTypeId (blank : false)
        periodName (blank : false)
        dateCreated()
        lastUpdated()
    }

    String toString(){
        return "${periodName}"
    }
}
