package com.gl

import com.app.*

class GlAccountOrgBal {

    BigDecimal Balance=0.00

    static belongsTo = [organization : AppOrganization,
                    acctgPeriod : AcctgPeriod,
                    glAccount : GlAccount]

    static constraints = {
    }
}
