package com.app

class AppUser {
    static auditable = true
    String username
    String password
    //String firstName //to be removed
    //String lastName //to be removed
    Date lastLogin = new Date()
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [role : AppRole,
                    party : Party]

    static constraints = {
        username(blank : false, unique : true)
        password(password : true, blank : false, nullable: false)
        //firstName(blank : false)
        //lastName(blank : false)
        role(blank : false)
        lastLogin(display : false, blank : true, nullable : true);
    }

    def beforeInsert = {
        password = password.encodeAsSHA()
    }
    def beforeUpdate = {
        password = password.encodeAsSHA()
    }
}
