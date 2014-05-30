package com.ar

class ReceivablesController {

    def beforeInterceptor = [action:this.&auth]

    def auth() {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }
    }

	def receivable = {
		render(view: "receivable")
    }

    def remittance = {
		render(view: "remittance")
    }

    def collection = {
    	render(view: "collection")
    }

    def violation = {
    	render(view: "violation")
    }

    def summary = {
    	render(view: "summary")
    }

    def test = {
        
    }
}