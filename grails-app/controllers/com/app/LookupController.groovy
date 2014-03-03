package com.app

import grails.converters.deep.JSON
import com.app.*

class LookupController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def beforeInterceptor = [action:this.&auth]

    def lookupService;

    def auth() {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }
    }

    def glAccount  = {
        render lookupService.lookupGlAccounts(params, session.organization.id) as JSON
    }

    def payeeWithTin = {
    	render lookupService.lookupPayeeAndTin(params) as JSON
    }


}