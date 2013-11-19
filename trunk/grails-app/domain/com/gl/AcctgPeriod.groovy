package com.gl

import com.app.AppOrganization

class AcctgPeriod {
        Integer acctgPeriodNum
        String month
        String year
        String status = 'Open'
        Date fromDate
        Date thruDate
        Date dateCreated

    

    static belongsTo = [periodTypeId : PeriodType,
                       organization : AppOrganization]
    
    static constraints = {
        acctgPeriodNum (blank : false)
        month (blank : false, inList: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'])
        status (blank : true, inList: ['Open', 'Close'])
        fromDate (blank : false)
        thruDate (blank : false)
        year (blank : true)
        dateCreated()
    }
    String toString() {
        return "${month} ${year}"
    }

}
