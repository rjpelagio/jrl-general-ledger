package com.gl

class GlAccount implements Serializable{
    
    String glAccount
    String description
    GlAccount parentGlAccount
    Date dateCreated
    Date lastUpdated

    static hasMany = [glAccountId : GlAccountOrganization]
    
    static belongsTo = [glAccountType : GlAccountType]

    static constraints = {
        glAccount(blank: false, unique: true)
        description(blank: false)
        glAccountType(blank:false)
        parentGlAccount(blank:true, nullable:true)
    }
    
    static mapping = {
        glAccount type: 'text'
        description type : 'text'
    }
    
    
    String toString(){
        return "${description} -- ${glAccount}"
    }
}
