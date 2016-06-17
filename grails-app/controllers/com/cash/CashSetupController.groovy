package com.cash

import com.gl.GlAccount

class CashSetupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def beforeInterceptor = [action:this.&auth]

    def auth() {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def setup = {
        
        def setup = CashSetup.get(1)
        render (view: "setup", model : [setup : setup])
    }

    def save = {

        def setup = CashSetup.get(1)
        setup.cashVoucherAcctTitle = GlAccount.get(params.cashVoucherAcctTitleId)
        setup.reimbursementAcctTitle = GlAccount.get(params.reimbursementAcctTitleId)
        setup.liquidationAcctTitle = GlAccount.get(params.liquidationAcctTitleId)
        //setup.replenishmentAcctTitle = GlAccount.get(params.replenishmentAcctTitleId)
        setup.reimbursementCreditAccount = GlAccount.get(params.reimbursementCreditAccountId)
        setup.reimbursementDebitAccount = GlAccount.get(params.reimbursementDebitAccountId)
        setup.replenishmentNegVariance = GlAccount.get(params.replenishmentNegVarianceId)
        setup.replenishmentPosVariance = GlAccount.get(params.replenishmentPosVarianceId)
        setup.lastUpdated = new Date()

        if (setup.validate()) {
            if (setup.save(flush:true)) {
                flash.message = "Cash Default accounts were successfully updated."
                render(view: "setup", model : [setup: setup])
            } else {
                render(view: "setup", model: [setup: setup])
            }
        } else {
            render(view: "setup", model: [setup: setup])
        }

    }
}
