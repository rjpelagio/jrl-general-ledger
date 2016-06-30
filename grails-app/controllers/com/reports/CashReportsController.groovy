package com.reports

import com.cash.*

class CashReportsController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def beforeInterceptor = [action:this.&auth]

	def auth() {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }

        flash.errors = null
    }

    def index = {
        redirect(action: "cashVoucher", params: params)
    }


    def cashVoucher = {


    }

    def replenishmentSummary = {

    }

    def liquidationSummary = {

    }

    def cashAdvanceSummary = {
        
    }

    def reimbursementSummary = {
        
    }





}