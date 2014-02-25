package com.app

class Employee {
    String department
    String position
    String status

    static belongsTo = [party : Party]

    static constraints = {
        department (blank: false, nullable: false, inList : ['Administration', 'Finance', 'HR', 'Sales'])
        position (blank: false, nullable: false, inList : ['Clerk', 'Supervisor', 'Manager'])
        status (blank: false, nullable: false, inList : ['Active','Inactive'])
    }
}
