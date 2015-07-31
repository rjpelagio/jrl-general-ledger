package com.gl

class GlAccount implements Serializable{
    
    static auditable = true
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
    
    //static mapping = {
    //    glAccount sqlType : "varchar", length : 30
    //    description sqlType : "varchar", length : 50
    //}
    
    
    String toString(){
        return "${description} -- ${glAccount}"
    }
}
