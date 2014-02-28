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
    String role

    //Contact Mech Fields
    Integer contactMechId;
    Integer postalAddressId;
    Integer elecAddressId;
    Integer telInfoId;

    //Postal Address

    String addressLine1;
    String addressLine2;
    String city;
    String province;
    String postalCode;

    //Email Address
    String emailAddress;

    //Telephone Info
    String areaCode;
    String contactNumber;
    String contactPerson;
    String mobileNumber;

    String testField;


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
        role (blank: false, nullable : false, bindable: true, inList : ["Customer", "Supplier","Organization"])

        contactMechId(blank : true, nullable : true, bindable : true)
        postalAddressId(blank : true, nullable : true, bindable : true)
        elecAddressId(blank : true, nullable : true, bindable : true)
        telInfoId(blank : true, nullable : true, bindable : true)

        addressLine1(blank: false, bindable: true)
        addressLine2(blank: true, bindable: true)
        city(blank: false, bindable: true)
        province(blank: false, bindable: true)
        postalCode(blank: false, bindable: true, matches : '^[0-9]*$')

        emailAddress(blank: false, email : true, bindable : true)

        areaCode (blank : false, bindable : true, matches : '^[0-9]*$')
        contactNumber (blank : false, bindable : true, matches : '^[0-9]*$')
        contactPerson (blank : true, bindable : true)
        mobileNumber (blank: false, bindable : true, matches : '^[0-9]*$')
    }
    
    
}

