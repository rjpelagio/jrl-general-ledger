package com.app

class EmployeeData implements Serializable {
	
	Integer empId;
	Integer version
	Integer partyId
	Integer personId
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
    String status

    static constraints = {
    	empId(blank : true, nullable : true, bindable : true)
    	version(blank : true, nullable : true, bindable : true)
    	partyId(blank: true, nullable : true, bindable : true)
    	personId(blank: true, nullable : true, bindable : true)
    	fullName(blank: false, nullable : false, bindable: true)
		personalTitle(blank: false, bindable: true, inList : ["Mr", "Ms", "Mrs", "Dr", "Eng"])
		firstName(blank: false, bindable: true)
		middleName(blank: false, bindable: true)
	    lastName(blank: false, bindable: true)
	    birthdate(blank: false, nullable : false, bindable: true)
	    gender (blank: false, bindable: true, inList : ["Male", "Female"])
	    maritalStatus (blank: false, bindable: true, inList : ["Married", "Divorced", "Separated", "Widowed"])
	    tin(blank: false, bindable: true)
	    department (blank: false, nullable: false, bindable: true, inList : ["Administration", "Finance", "HR", "Sales"])
        position (blank: false, nullable: false, bindable: true, inList : ['Clerk', 'Supervisor', 'Manager'])
        status (blank: false, nullable : false, bindable : true,  inList : ['Active', 'Inactive'])
    }
    
    


}