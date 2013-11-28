package com.app

class EmployeeData {
	
	String fullName
	String personalTitle
	String firstName
	String middleName
    String lastName
    Date birthdate
    String gender 
    String maritalStatus 
    String tin
    String department
    String position

    static constraints = {
    	fullName(blank: false)
		personalTitle(blank: false)
		firstName(blank: false)
		middleName(blank: false)
	    lastName(blank: false)
	    birthdate(blank: false)
	    gender (blank: false)
	    maritalStatus (blank: false)
	    tin(blank: false)
	    department (blank: false, nullable: false, inList : ['Administration', 'Finance', 'HR', 'Sales'])
        position (blank: false, nullable: false, inList : ['Clerk', 'Supervisor', 'Manager'])
    }
    
    


}