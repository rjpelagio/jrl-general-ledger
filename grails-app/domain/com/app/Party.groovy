package com.app

class Party implements Serializable{
    String name
    String firstName
    String middleName
    String lastName
    String tin
    
    static mapping = {
        id column: "party_id"
    }


    static constraints = {
        name (blank : false, unique : true)
        firstName (blank : false)
        middleName (blank : false)
        lastName (blank : false)
        tin (blank : true, nullable : true)
    }

    String toString() {
        return "${name}"
    }
}
