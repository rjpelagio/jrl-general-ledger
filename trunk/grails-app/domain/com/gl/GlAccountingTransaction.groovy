package com.gl

import com.app.*

class GlAccountingTransaction {
    
    String description
    Date transactionDate
    Date postedDate
    Date entryDate
    String voucherNo
    String tinNo
    Date ckSiDate
    String checkNo
    String terms
    String refDoc
    BigDecimal cdoKg
    Date dateCreated
    Date lastUpdated
    String status
    String printed = 'No'

    static belongsTo = [organization : AppOrganization,
                        party :  Party,
                        acctgTransType : AcctgTransType]
    
    static hasMany = [item : GlAccountingTransactionDetails]
    
    static constraints = {
        description (blank : false)
        organization ()
        transactionDate (blank : false)
        postedDate (nullable : true, blank : true)
        entryDate ()
        voucherNo (blank: false, nullable : false, unique: true)
        tinNo (blank: true, nullable : true)
        ckSiDate (blank : true, nullable : true)
        checkNo (blank : true, nullable : true)
        terms (blank : true, nullable : true)
        cdoKg (blank : true, nullable : true)
        refDoc (blank : true, nullable : true)
        status (blank: true, inList: ['Active', 'For Approval', 'Cancelled', 'Approved'])
        printed (inList: ['Yes', 'No'])
    }
}
