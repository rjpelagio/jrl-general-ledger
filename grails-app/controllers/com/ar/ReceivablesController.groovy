package com.ar

class ReceivablesController {

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
}