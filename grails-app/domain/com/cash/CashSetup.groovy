package com.cash

import com.app.*
import com.gl.GlAccount

class CashSetup {
	
	Date lastUpdated

	static belongsTo = [organization : AppOrganization,
		cashVoucherAcctTitle : GlAccount,
		reimbursementAcctTitle : GlAccount,
		liquidationAcctTitle : GlAccount,
		replenishmentAcctTitle : GlAccount,
		reimbursementCreditAccount : GlAccount,
		reimbursementDebitAccount : GlAccount,
		replenishmentNegVariance : GlAccount,
		replenishmentPosVariance : GlAccount]



	static mapping = {
        preparedBy column: "preparedBy"
    }

	static constraints = {
        
    }


}