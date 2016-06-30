package com.cash

import com.gl.*
import com.app.*

class LiquidationItems {
    
    String description
    BigDecimal amount = 0.00
    String refDoc



    static belongsTo = [liquidation : Liquidation, glAccount : GlAccount, payee : Party]

    static constraints = {
        liquidation (blank : false)
        amount(min : 0.0)
    }
}