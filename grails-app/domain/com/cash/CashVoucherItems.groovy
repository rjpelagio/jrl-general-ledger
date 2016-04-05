package com.cash

import com.gl.*
import com.app.*

class CashVoucherItems implements Serializable {
    
    static auditable = true
    String description
    BigDecimal amount = 0.00
    String referenceDoc

    
    static belongsTo = [glAccount : GlAccount, cashVoucher : CashVoucher, payee : Party]

    static constraints = {
        cashVoucher (blank : false)
        glAccount(blank : true, nullable : true)
        payee(blank : false)
        amount(min : 0.0)
        referenceDoc(blank : true)
    }
}