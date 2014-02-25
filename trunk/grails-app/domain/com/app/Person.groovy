package com.app

class Person {
    String lastName
    String firstName
    String middleName
    String personalTitle
    String suffix
    String nickname
    String gender
    Date birthdate
    String maritalStatus
    String comment

    static belongsTo = [party : Party]

    static constraints = {
        personalTitle (inList : ["Ms", "Mr", "Mrs", "Dr", "Eng"])
        firstName (blank : false)
        lastName (blank : false)
        middleName (blank : true, nullable : true)
        nickname (blank : true)
        suffix (blank : true, nullable : true)
        gender (inList : ["Male", "Female"])
        birthdate()
        maritalStatus (inList : ["Single", "Married", "Divorced", "Separated", "Widowed"])
        comment (blank : true, nullable : true, display : "false")
    }

    String toString() {
        return "${firstName} " + " " + "${lastName}"
    }
}
