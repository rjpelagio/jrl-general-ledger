import grails.util.GrailsUtil
import com.app.*
import com.gl.*

class PartyBootStrap {

	def init = { servletContext ->

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
                            suffix : "Mr.")
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


        /** EMPLOYE CONTACT DETAILS **/

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

        /** END EMPLOYE CONTACT DETAILS **/

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








	}

	def destroy = {

	}


}