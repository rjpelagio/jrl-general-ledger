package com.gl

class AcctgTransType {
	static auditable = true
    String acctgTransCode
    String acctgTransName
    
    static constraints = {
        acctgTransCode (blank : false)
        acctgTransName (blank : false)
    }

    String toString(){
        return "${acctgTransCode}"
    }
}
