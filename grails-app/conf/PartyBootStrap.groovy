import grails.util.GrailsUtil
import com.app.*
import com.gl.*

class PartyBootStrap {

	def init = { servletContext ->

        /** MANAGER SAMPLE DATA ENTRY **/

		def empParty = new Party(name: "RJ Pelagio",
                        firstName: "RJ",
                        middleName: "Valencia",
                        lastName: "Pelagio",
                        tin: "1111-1111-0000")
        if(!Party.find(empParty)){
            empParty.save()
            if(empParty.hasErrors()){
                println empParty.errors
            }
        }

        def empPerson = new Person(firstName : "RJ",
                            lastName : "Pelagio",
                            gender : "Male",
                            nickname : "RJ",
                            birthdate : "11/01/2015",
                            maritalStatus : "Single",
                            party : Party.find(empParty),
                            personalTitle : "Mr",
                            comment : "Initial Entry",
                            middleName : "Rosario",
                            suffix : "")
        if(!Person.find(empPerson) && Party.find(empParty)){
            empPerson.save()
            if(empPerson.hasErrors()){
                println empPerson.errors
            }
        }

        def empInstance = new Employee(party : Party.find(empParty),
                                        department : "Finance",
                                        position : "Manager",
                                        status : "Active")
        if(!Employee.find(empInstance)) {
            empInstance.save()
            if (empInstance.hasErrors()) {
                println empInstance.errors
            }
        }

        def empContactMechPostalEntry = new ContactMech (contactMechType : "POSTAL_ADDRESS")
        empContactMechPostalEntry.save()

        def empPartyPostalContact = new PartyContactMech(contactMech : ContactMech.get(empContactMechPostalEntry.id),
                                        party : Party.find(empParty),
                                        fromDate : new Date(),
                                        purpose : "Contact Detail",
                                        contactMechType: "POSTAL_ADDRESS")
        if(!PartyContactMech.find(empPartyPostalContact)){
            empPartyPostalContact.save()
            if(empPartyPostalContact.hasErrors()){
                println empPartyPostalContact.errors
            }
        } 

        def empAddress = new PostalAddress(addressLine1 : "357 St Mark Street",
                                        addressLine2 : "St Augustine Village, Lawa",
                                        city : "Calamba",
                                        province : "Laguna",
                                        postalCode : "4027",
                                        contactMech : ContactMech.get(empContactMechPostalEntry.id))
        if(!PostalAddress.find(empAddress) && ContactMech.get(empContactMechPostalEntry.id)){
            empAddress.save()
            if(empAddress.hasErrors()){
                println empAddress.errors
            }
        }

        def empContactMechTelEntry = new ContactMech (contactMechType : "PHONE_INFO")
        empContactMechTelEntry.save()

        def empPartyPhoneContact = new PartyContactMech(contactMech : ContactMech.get(empContactMechTelEntry.id),
                                        party : Party.find(empParty),
                                        fromDate : new Date(),
                                        purpose : "Contact Detail",
                                        contactMechType: "PHONE_INFO")
        if(!PartyContactMech.find(empPartyPhoneContact)){
            empPartyPhoneContact.save()
            if(empPartyPhoneContact.hasErrors()){
                println empPartyPhoneContact.errors
            }
        }

        def empTelInfo = new TeleInfo(areaCode: "049",
                                    contactNumber : "5022597",
                                    contactMech : ContactMech.get(empContactMechTelEntry.id),
                                    contactPerson : "Jephy",
                                    mobileNumber : "09174729235")
        if(!TeleInfo.find(empTelInfo) && ContactMech.get(empContactMechTelEntry.id)){
            empTelInfo.save()
            if(empTelInfo.hasErrors()){
                println empTelInfo.errors
            }
        }

        def empEmailEntry = new ContactMech(contactMechType : "EMAIL_ADDRESS")
        empEmailEntry.save()

        def empPartyEmailContact = new PartyContactMech(contactMech : ContactMech.get(empEmailEntry.id),
                                        party : Party.find(empParty),
                                        fromDate : new Date(),
                                        purpose : "Contact Detail",
                                        contactMechType: "EMAIL_ADDRESS")
        if(!PartyContactMech.find(empPartyEmailContact)){
            empPartyEmailContact.save()
            if(empPartyEmailContact.hasErrors()){
                println empPartyEmailContact.errors
            }
        }

        def empEmailInfo = new ElecAddress (emailString: "rjpelagio@gmail.com",
                                    contactMech : ContactMech.get(empEmailEntry.id))
        if(!ElecAddress.find(empEmailInfo) && ContactMech.get(empEmailEntry.id)){
            empEmailInfo.save()
            if(empEmailInfo.hasErrors()){
                println empEmailInfo.errors
            }
        }

        def empPartyRole = new PartyRole ( Party : empParty,
                        fromDate : new Date(),
                        status : "Active",
                        role : AppRole.findByRoleCode("EMP")
                        )
        if(!PartyRole.find(empPartyRole)) {
            empPartyRole.save()
            if(empPartyRole.hasErrors()){
                println empPartyRole.errors
            }
        }

        def empLogin = new AppUser(username:"rjpelagio",
                    password:"rjpelagio",
                    dateCreated: new Date(),
                    lastLogin: new Date(),
                    lastUpdated : new Date(),
                    role:AppRole.get(6),
                    party:Party.get(3))
        if(!AppUser.find(empLogin)){
            empLogin.save()
            if(empLogin.hasErrors()){
                println empLogin.errors
            }
        }

        /** END MANAGER SAMPLE DATA ENTRY **/

        /** SUPERVISOR SAMPLE DATA ENTRY **/

        def supParty = new Party(name: "Yna Macaspac",
                        firstName: "Yna",
                        middleName: "Powers",
                        lastName: "Macaspac",
                        tin: "1111-1111-2222")
        if(!Party.find(supParty)){
            supParty.save()
            if(supParty.hasErrors()){
                println supParty.errors
            }
        }

        def supPerson = new Person(firstName : "Yna",
                            lastName : "Macaspac",
                            gender : "Female",
                            nickname : "Yna",
                            birthdate : "03/15/2013",
                            maritalStatus : "Single",
                            party : Party.find(supParty),
                            personalTitle : "Ms",
                            comment : "Initial Entry",
                            middleName : "Powers",
                            suffix : "")
        if(!Person.find(supPerson) && Party.find(supParty)){
            supPerson.save()
            if(supPerson.hasErrors()){
                println supPerson.errors
            }
        }

        def supInstance = new Employee(party : Party.find(supParty),
                                        department : "Finance",
                                        position : "Supervisor",
                                        status : "Active")
        if(!Employee.find(supInstance)) {
            supInstance.save()
            if (supInstance.hasErrors()) {
                println supInstance.errors
            }
        }

        def supContactMechPostalEntry = new ContactMech (contactMechType : "POSTAL_ADDRESS")
        supContactMechPostalEntry.save()

        def supPartyPostalContact = new PartyContactMech(contactMech : ContactMech.get(supContactMechPostalEntry.id),
                                        party : Party.find(supParty),
                                        fromDate : new Date(),
                                        purpose : "Contact Detail 2",
                                        contactMechType: "POSTAL_ADDRESS")
        if(!PartyContactMech.find(supPartyPostalContact)){
            supPartyPostalContact.save()
            if(supPartyPostalContact.hasErrors()){
                println supPartyPostalContact.errors
            }
        } 

        def supAddress = new PostalAddress(addressLine1 : "41 Binondo Drive",
                                        addressLine2 : "P Tuazon corner Edsa",
                                        city : "Mandaluyong City",
                                        province : "Manila",
                                        postalCode : "4027",
                                        contactMech : ContactMech.get(supContactMechPostalEntry.id))
        if(!PostalAddress.find(supAddress) && ContactMech.get(supContactMechPostalEntry.id)){
            supAddress.save()
            if(supAddress.hasErrors()){
                println supAddress.errors
            }
        }

        def supContactMechTelEntry = new ContactMech (contactMechType : "PHONE_INFO")
        supContactMechTelEntry.save()

        def supPartyPhoneContact = new PartyContactMech(contactMech : ContactMech.get(supContactMechTelEntry.id),
                                        party : Party.find(supParty),
                                        fromDate : new Date(),
                                        purpose : "Contact Detail",
                                        contactMechType: "PHONE_INFO")
        if(!PartyContactMech.find(supPartyPhoneContact)){
            supPartyPhoneContact.save()
            if(supPartyPhoneContact.hasErrors()){
                println supPartyPhoneContact.errors
            }
        }

        def supTelInfo = new TeleInfo(areaCode: "02",
                                    contactNumber : "8475521",
                                    contactMech : ContactMech.get(supContactMechTelEntry.id),
                                    contactPerson : "Jephy",
                                    mobileNumber : "09174729235")
        if(!TeleInfo.find(supTelInfo) && ContactMech.get(supContactMechTelEntry.id)){
            supTelInfo.save()
            if(supTelInfo.hasErrors()){
                println supTelInfo.errors
            }
        }

        def supEmailEntry = new ContactMech(contactMechType : "EMAIL_ADDRESS")
        supEmailEntry.save()

        def supPartyEmailContact = new PartyContactMech(contactMech : ContactMech.get(supEmailEntry.id),
                                        party : Party.find(supParty),
                                        fromDate : new Date(),
                                        purpose : "Contact Detail",
                                        contactMechType: "EMAIL_ADDRESS")
        if(!PartyContactMech.find(supPartyEmailContact)){
            supPartyEmailContact.save()
            if(supPartyEmailContact.hasErrors()){
                println supPartyEmailContact.errors
            }
        }

        def supEmailInfo = new ElecAddress (emailString: "rjpelagio@gmail.com",
                                    contactMech : ContactMech.get(supEmailEntry.id))
        if(!ElecAddress.find(supEmailInfo) && ContactMech.get(supEmailEntry.id)){
            supEmailInfo.save()
            if(supEmailInfo.hasErrors()){
                println supEmailInfo.errors
            }
        }

        def supPartyRole = new PartyRole ( Party : supParty,
                        fromDate : new Date(),
                        status : "Active",
                        role : AppRole.findByRoleCode("EMP")
                        )
        if(!PartyRole.find(supPartyRole)) {
            supPartyRole.save()
            if(supPartyRole.hasErrors()){
                println supPartyRole.errors
            }
        }

        def supLogin = new AppUser(username:"ynamacaspac",
                    password:"ynamacaspac",
                    dateCreated: new Date(),
                    lastLogin: new Date(),
                    lastUpdated : new Date(),
                    role:AppRole.get(6),
                    party:Party.find(supParty))
        if(!AppUser.find(supLogin)){
            supLogin.save()
            if(supLogin.hasErrors()){
                println supLogin.errors
            }
        }

        /** END SUPERVISOR SAMPLE DATA ENTRY **/

        /** CLERK SAMPLE DATA ENTRY **/

        def cleParty = new Party(name: "Clara del Valle",
                        firstName: "Clara",
                        middleName: "Davis",
                        lastName: "del Valle",
                        tin: "1111-1111-3333")
        if(!Party.find(cleParty)){
            cleParty.save()
            if(cleParty.hasErrors()){
                println cleParty.errors
            }
        }

        def clePerson = new Person(firstName : "Clara",
                            lastName : "del Valle",
                            gender : "Female",
                            nickname : "Clara",
                            birthdate : "03/15/2013",
                            maritalStatus : "Single",
                            party : Party.find(cleParty),
                            personalTitle : "Ms",
                            comment : "Initial Entry",
                            middleName : "Powers",
                            suffix : "")
        if(!Person.find(clePerson) && Party.find(cleParty)){
            clePerson.save()
            if(clePerson.hasErrors()){
                println clePerson.errors
            }
        }

        def cleInstance = new Employee(party : Party.find(cleParty),
                                        department : "Finance",
                                        position : "Clerk",
                                        status : "Active")
        if(!Employee.find(cleInstance)) {
            cleInstance.save()
            if (cleInstance.hasErrors()) {
                println cleInstance.errors
            }
        }

        def cleContactMechPostalEntry = new ContactMech (contactMechType : "POSTAL_ADDRESS")
        cleContactMechPostalEntry.save()

        def clePartyPostalContact = new PartyContactMech(contactMech : ContactMech.get(cleContactMechPostalEntry.id),
                                        party : Party.find(cleParty),
                                        fromDate : new Date(),
                                        purpose : "Contact Detail 2",
                                        contactMechType: "POSTAL_ADDRESS")
        if(!PartyContactMech.find(clePartyPostalContact)){
            clePartyPostalContact.save()
            if(clePartyPostalContact.hasErrors()){
                println clePartyPostalContact.errors
            }
        } 

        def cleAddress = new PostalAddress(addressLine1 : "22nd Street",
                                        addressLine2 : "Corazon Ave",
                                        city : "Marikina City",
                                        province : "Manila",
                                        postalCode : "4022",
                                        contactMech : ContactMech.get(cleContactMechPostalEntry.id))
        if(!PostalAddress.find(cleAddress) && ContactMech.get(cleContactMechPostalEntry.id)){
            cleAddress.save()
            if(cleAddress.hasErrors()){
                println cleAddress.errors
            }
        }

        def cleContactMechTelEntry = new ContactMech (contactMechType : "PHONE_INFO")
        cleContactMechTelEntry.save()

        def clePartyPhoneContact = new PartyContactMech(contactMech : ContactMech.get(cleContactMechTelEntry.id),
                                        party : Party.find(cleParty),
                                        fromDate : new Date(),
                                        purpose : "Contact Detail",
                                        contactMechType: "PHONE_INFO")
        if(!PartyContactMech.find(clePartyPhoneContact)){
            clePartyPhoneContact.save()
            if(clePartyPhoneContact.hasErrors()){
                println clePartyPhoneContact.errors
            }
        }

        def cleTelInfo = new TeleInfo(areaCode: "02",
                                    contactNumber : "2036021",
                                    contactMech : ContactMech.get(cleContactMechTelEntry.id),
                                    contactPerson : "Jephy",
                                    mobileNumber : "09174729235")
        if(!TeleInfo.find(cleTelInfo) && ContactMech.get(cleContactMechTelEntry.id)){
            cleTelInfo.save()
            if(cleTelInfo.hasErrors()){
                println cleTelInfo.errors
            }
        }

        def cleEmailEntry = new ContactMech(contactMechType : "EMAIL_ADDRESS")
        cleEmailEntry.save()

        def clePartyEmailContact = new PartyContactMech(contactMech : ContactMech.get(cleEmailEntry.id),
                                        party : Party.find(cleParty),
                                        fromDate : new Date(),
                                        purpose : "Contact Detail",
                                        contactMechType: "EMAIL_ADDRESS")
        if(!PartyContactMech.find(clePartyEmailContact)){
            clePartyEmailContact.save()
            if(clePartyEmailContact.hasErrors()){
                println clePartyEmailContact.errors
            }
        }

        def cleEmailInfo = new ElecAddress (emailString: "rjpelagio@gmail.com",
                                    contactMech : ContactMech.get(cleEmailEntry.id))
        if(!ElecAddress.find(cleEmailInfo) && ContactMech.get(cleEmailEntry.id)){
            cleEmailInfo.save()
            if(cleEmailInfo.hasErrors()){
                println cleEmailInfo.errors
            }
        }

        def clePartyRole = new PartyRole ( Party : cleParty,
                        fromDate : new Date(),
                        status : "Active",
                        role : AppRole.findByRoleCode("EMP")
                        )
        if(!PartyRole.find(clePartyRole)) {
            clePartyRole.save()
            if(clePartyRole.hasErrors()){
                println clePartyRole.errors
            }
        }

        def cleLogin = new AppUser(username:"claram",
                    password:"claram",
                    dateCreated: new Date(),
                    lastLogin: new Date(),
                    lastUpdated : new Date(),
                    role:AppRole.get(6),
                    party:Party.find(cleParty))
        if(!AppUser.find(cleLogin)){
            cleLogin.save()
            if(cleLogin.hasErrors()){
                println cleLogin.errors
            }
        }

        /** END CLERK SAMPLE DATA ENTRY **/

	}

	def destroy = {

	}


}