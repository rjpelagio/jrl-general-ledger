package com.gl

class GlAccountingTransactionDetails {
    
    String debitCreditFlag
    BigDecimal amount
    int sequenceId
    
    static belongsTo = [glAccount : GlAccount,
                        glAccountingTransaction : GlAccountingTransaction]

    static constraints = {
        glAccountingTransaction (blank : false)
        glAccount(blank : false)
        debitCreditFlag(inList:["Debit","Credit"])
        amount(min : 0.0)
        sequenceId(display : false)
    }
}
