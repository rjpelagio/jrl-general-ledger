package com.app

class AppRole {
    
    String roleCode
    String roleName
    AppRole parent
    Date dateCreated
    Date lastUpdated

    static belongsTo = [id : AppUser]

    static constraints = {
        roleCode(blank : false, unique : true)
        roleName(blank : false, unique : true)
        parent(blank : true, nullable : true)
    }
    
    String toString(){
        return "${roleName}"
    }
    
}
