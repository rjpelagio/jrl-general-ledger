package com.cash

import com.gl.*

class CashVoucherItems {
    
    static auditable = true
    String particulars
    BigDecimal amount = 0.00
    String referenceDoc

    
    static belongsTo = [glAccount : GlAccount,
                        cashVoucher : CashVoucher]

    static constraints = {
        cashVoucher (blank : false)
        glAccount(blank : false)
        particulars(blank : false)
        amount(min : 0.0)
        referenceDoc(blank : true)
    }
}