package com.gl

class GlAccountType {
    
    String glAccountType
    String description
    String glAccountClass = 'Asset'
    Date dateCreated
    Date lastUpdated

    static constraints = {
        glAccountType (blank: false, unique: true)
        description (blank: false)
        glAccountClass (blank: false, inList: ['Asset', 'Liability', 'Equity', 'Income', 'Expense'])
        id (display: false)
    }
    
    static mapping = {
        glAccountType type: 'text'
        description type : 'text'
        sort "glAccountType"
    }
    
    String toString(){
        return "${description}"
    }
}
