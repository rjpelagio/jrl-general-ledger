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
        //id (display: false)
    }
    
    //static mapping = {
    //    glAccountType sqlType : "varchar", length : 30
    //    description sqlType : "varchar", length : 50
        //sort "glAccountType"
    //}
    
    String toString(){
        return "${description}"
    }
}
