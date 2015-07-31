package com.app

class TransactionLog {

	String action
	String entityName
	String login
	Date transactionDate = new Date()

	static constraints = {
        action(blank : false,  nullable : false, inList : ["Create", "Update"])
        entityName(blank: false, nullable : false)
        login(blank:false, nullable:false)
    }

}