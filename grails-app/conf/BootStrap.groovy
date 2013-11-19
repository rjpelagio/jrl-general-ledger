import grails.util.GrailsUtil
import com.app.*
import com.gl.*

class BootStrap {
    def init = { servletContext ->
        def jrl = new Party(name: "JRL Endaya Inc.",
                        firstName: "Juan",
                        middleName: "C.",
                        lastName: "dela Cruz")
        if(!Party.find(jrl)){
            jrl.save()
            if(jrl.hasErrors()){
                println jrl.errors
            }
        }

        def jrlperson = new Person(firstName : "Juan",
                            lastName : "dela Cruz",
                            gender : "Male",
                            nickname : "JRL",
                            birthdate : "11/01/2011",
                            maritalStatus : "Single",
                            party : Party.find(jrl),
                            personalTitle : "Mr",
                            comment : "Initial Entry",
                            middleName : "Rosario",
                            suffix : "Mr.")
        if(!Person.find(jrlperson) && Party.find(jrl)){
            jrlperson.save()
            if(jrlperson.hasErrors()){
                println jrlperson.errors
            }
        }

        def organization = new AppOrganization(organizationCode:"JRL",
                            organizationName:"JRL Endaya Inc.",
                            organizationType:"Legal Organization",
                            party:Party.find(jrl))
        if(!AppOrganization.find(organization)){
            organization.save()
            if(organization.hasErrors()){
                println organization.errors
            }
        }

        def postalAddress = new ContactMechType(contactMechType : "POSTAL_ADDRESS",
                            description : "Postal Address")

        if(!ContactMechType.find(postalAddress)){
            postalAddress.save()
            if(postalAddress.hasErrors()){
                println postalAddress.errors
            }
        }

        def phoneNumber = new ContactMechType(contactMechType : "TELECOM_NUMBER",
                            description : "Phone Number")
        if(!ContactMechType.find(phoneNumber)){
            phoneNumber.save()
            if(phoneNumber.hasErrors()){
                println phoneNumber.errors
            }
        }

        def emailAddress = new ContactMechType(contactMechType : "ELECTRONIC_ADDRESS",
                            description : "Electronic Address")
        if(!ContactMechType.find(emailAddress)){
            emailAddress.save()
            if(emailAddress.hasErrors()){
                println emailAddress.errors
            }
        }

        def contactMech1 = new ContactMech(contactMechType : ContactMechType.find(postalAddress))
        if(!ContactMech.find(contactMech1) && ContactMechType.find(postalAddress)){
            contactMech1.save()
            if(contactMech1.hasErrors()){
                println contactMech1.errors
            }
        }

        def contactMech2 = new ContactMech(contactMechType : ContactMechType.find(phoneNumber))
        if(!ContactMech.find(contactMech2) && ContactMechType.find(phoneNumber)){
            contactMech2.save()
            if(contactMech2.hasErrors()){
                println contactMech2.errors
            }
        }

        def contactMech3 = new ContactMech(contactMechType : ContactMechType.find(emailAddress))
        if(!ContactMech.find(contactMech3) && ContactMechType.find(emailAddress)){
            contactMech3.save()
            if(contactMech3.hasErrors()){
                println contactMech3.errors
            }
        }

        def partyContact = new PartyContactMech(contactMech : ContactMech.find(contactMech1),
                                        party : Party.find(jrl),
                                        fromDate : "11/01/2011",
                                        purpose : "Contact Detail")
        if(!PartyContactMech.find(partyContact) && ContactMech.find(contactMech1)){
            partyContact.save()
            if(partyContact.hasErrors()){
                println partyContact.errors
            }
        }

        def address1 = new PostalAddress(address1 : "Cabuyao Central, Cabuyao, Laguna",
                                        contactMech : contactMech1)
        if(!PostalAddress.find(address1) && ContactMech.find(contactMech1)){
            address1.save()
            if(address1.hasErrors()){
                println address1.errors
            }
        }

        def address2 = new TeleInfo(countryCode : "63",
                                    areaCode: "049",
                                    contactNumber : "531-1696",
                                    contactMech : contactMech1,
                                    contactPerson : "Rhodalyn Rolle")
        if(!TeleInfo.find(address2) && ContactMech.find(contactMech1)){
            address2.save()
            if(address2.hasErrors()){
                println address2.errors
            }
        }


        //def address3 = new ElecAddress(emailString : "jrlendayainc@yahoo.com",
        //                                contactMech : contactMech3)
        //if(!ContactMech.find(address3) && ContactMech.find(contactMech3)){
        //    address3.save()
        //    if(address3.hasErrors()){
        //        println address3.errors
        //    }
        //}

        def calcyear = new PeriodType(periodTypeId:"CALENDAR YEAR",
                            periodName:"Calendar Year")
        if(!PeriodType.find(calcyear)){
            calcyear.save()
            if(calcyear.hasErrors()){
                println calcyear.errors
            }
        }

        def acctgpd1 = new AcctgPeriod(acctgPeriodNum:"1",
                    month:"January",
                    fromDate:new Date('01/01/2011'),
                    thruDate:new Date('01/31/2011'),
                    periodTypeId:PeriodType.find(calcyear),
                    year: 2011,
                    organization:AppOrganization.find(organization))

        if(!AcctgPeriod.find(acctgpd1) && PeriodType.find(calcyear) && AppOrganization.find(organization)){
            acctgpd1.save()
            if(acctgpd1.hasErrors()){
                println acctgpd1.errors
            }
        }

        def acctgpd2 = new AcctgPeriod(acctgPeriodNum:"2",
                    month:"February",
                    fromDate:new Date('02/01/2011'),
                    thruDate:new Date('02/29/2011'),
                    periodTypeId:PeriodType.find(calcyear),
                    year: 2011,
                    organization:AppOrganization.find(organization))
        if(!AcctgPeriod.find(acctgpd2) && PeriodType.find(calcyear) && AppOrganization.find(organization)){
            acctgpd2.save()
            if(acctgpd2.hasErrors()){
                println acctgpd2.errors
            }
        }

        def acctgpd3 = new AcctgPeriod(acctgPeriodNum:"3",
                    month:"March",
                    fromDate:new Date('03/01/2011'),
                    thruDate:new Date('03/31/2011'),
                    periodTypeId:PeriodType.find(calcyear),
                    year: 2011,
                    organization:AppOrganization.find(organization))
       if(!AcctgPeriod.find(acctgpd3) && PeriodType.find(calcyear) && AppOrganization.find(organization)){
            acctgpd3.save()
            if(acctgpd3.hasErrors()){
                println acctgpd3.errors
            }
       }

        def acctgpd4 = new AcctgPeriod(acctgPeriodNum:"4",
                    month:"April",
                    fromDate:new Date('04/01/2011'),
                    thruDate:new Date('04/30/2011'),
                    periodTypeId:PeriodType.find(calcyear),
                    year: 2011,
                    organization:AppOrganization.find(organization))
        if(!AcctgPeriod.find(acctgpd4) && PeriodType.find(calcyear) && AppOrganization.find(organization)){
            acctgpd4.save()
            if(acctgpd4.hasErrors()){
                println acctgpd4.errors
            }
        }
        
        def assets = new GlAccountType(glAccountType:"ASSETS",
                    description:"Assets",
                    glAccountClass : "Asset")
        if(!GlAccountType.find(assets)){
            assets.save()
            if(assets.hasErrors()){
                println assets.errors
            }
        }


        def glAccount1 = new GlAccount(glAccount : "1010-000",
            description : "Cash and Cash in Banks",
            glAccountType : GlAccountType.find(assets))
        if(!GlAccount.find(glAccount1) && GlAccountType.find(assets)){
            glAccount1.save()
            if(glAccount1.hasErrors()){
                println glAccount1.errors
            }
        }
        
        def glAcctOrg1 = new GlAccountOrganization(glAccount : GlAccount.find(glAccount1),
            organization : AppOrganization.find(organization),
            startDate : "01/01/2011",
            thruDate : "12/31/2012");
        if(!GlAccountOrganization.find(glAcctOrg1)){
            glAcctOrg1.save();
            if(glAcctOrg1.hasErrors()){
                println glAcctOrg1.errors
            }
        }

        def glAccount2 = new GlAccount(glAccount : "1010-001",
            description : "Petty Cash Fund",
            glAccountType : GlAccountType.find(assets))
        if(!GlAccount.find(glAccount2) && GlAccountType.find(assets)){
            glAccount2.save()
            if(glAccount2.hasErrors()){
                println glAccount2.errors
            }
        }
        
        def glAcctOrg2 = new GlAccountOrganization(glAccount : GlAccount.find(glAccount2),
            organization : AppOrganization.find(organization),
            startDate : "01/01/2011",
            thruDate : "12/31/2012");
        if(!GlAccountOrganization.find(glAcctOrg2)){
            glAcctOrg2.save();
            if(glAcctOrg2.hasErrors()){
                println glAcctOrg2.errors
            }
        }

        def glAccount3 = new GlAccount(glAccount : "1011-001",
            description : "Cash",
            glAccountType : GlAccountType.find(assets),
            glAccountClass : "Asset")
        if(!GlAccount.find(glAccount3) && GlAccountType.find(assets)){
            glAccount3.save()
            if(glAccount3.hasErrors()){
                println glAccount3.errors
            }
        }

        def glAcctOrg3 = new GlAccountOrganization(glAccount : GlAccount.find(glAccount3),
            organization : AppOrganization.find(organization),
            startDate : "01/01/2011",
            thruDate : "12/31/2012");
        if(!GlAccountOrganization.find(glAcctOrg3)){
            glAcctOrg3.save();
            if(glAcctOrg3.hasErrors()){
                println glAcctOrg3.errors
            }
        }
        
        def acctgTran = new GlAccountingTransaction(description : "Sample GL Entries",
                    organization : AppOrganization.find(organization),
                    entryDate : "12/24/2011",
                    transactionDate : "12/24/2011",
                    postedDate : "12/25/2011",
                    party : Party.find(jrl),
                    status: "Active",
                    voucherNo: "JV-00001")
        if(!GlAccountingTransaction.find(acctgTran) && AppOrganization.find(organization) && Party.find(jrl)) {
            acctgTran.save()
            if(acctgTran.hasErrors()){
                println acctgTran.errors
            }
        }

        def acctgTranItem1 = new GlAccountingTransactionDetails(glAccount : GlAccount.find(glAccount1),
                    sequenceId : "1",
                    amount : "1000.00",
                    debitCreditFlag : "Debit",
                    glAccountingTransaction : GlAccountingTransaction.find(acctgTran))
        if(!GlAccountingTransactionDetails.find(acctgTranItem1) && GlAccount.find(glAccount1) && GlAccountingTransaction.find(acctgTran)) {
            acctgTranItem1.save()
            if(acctgTranItem1.hasErrors()){
               println acctgTranItem1.errors
            }
        }

        def acctgTranItem2 = new GlAccountingTransactionDetails(glAccount : GlAccount.find(glAccount2),
                    sequenceId : "2",
                    amount : "1000.00",
                    debitCreditFlag : "Debit",
                    glAccountingTransaction : GlAccountingTransaction.find(acctgTran))
        if(!GlAccountingTransactionDetails.find(acctgTranItem2) && GlAccount.find(glAccount2) && GlAccountingTransaction.find(acctgTran)) {
            acctgTranItem2.save()
            if(acctgTranItem2.hasErrors()){
               println acctgTranItem2.errors
            }
        }

        def acctgTranItem3 = new GlAccountingTransactionDetails(glAccount : GlAccount.find(glAccount3),
                    sequenceId : "3",
                    amount : "2000.00",
                    debitCreditFlag : "Credit",
                    glAccountingTransaction : GlAccountingTransaction.find(acctgTran))
        if(!GlAccountingTransactionDetails.find(acctgTranItem3) && GlAccount.find(glAccount3) && GlAccountingTransaction.find(acctgTran)) {
           acctgTranItem3.save()
           if(acctgTranItem3.hasErrors()){
               println acctgTranItem3.errors
           }
        }

        def admin = new AppRole(roleCode:"ADM",
                        roleName:"Administrator")
        if(!AppRole.find(admin)){
            admin.save()
            if(admin.hasErrors()){
                println admin.errors
            }
        }
        
        def user = new Party(name:"The JRL Administrator", firstName: "--", middleName: "--", lastName: "--")
        if(!Party.find(user)){
            user.save()
            if(user.hasErrors()){
                println user.errors
            }
        }

        def jrladmin = new AppUser(username:"jrladmin",
                    password:"jrladmin",
                    firstName:"JRL Administrator",
                    lastName:"The",
                    role:AppRole.find(admin),
                    party:Party.find(user))
        if(!AppUser.find(jrladmin) && AppRole.find(admin) && Party.find(user)){
            jrladmin.save()
            if(jrladmin.hasErrors()){
                println jrladmin.errors
            }
        }

        def superuser = new AppRole(roleCode:"SUSER",
                roleName:"Super User")
        if(!AppRole.find(superuser)){
            superuser.save()
            if(superuser.hasErrors()){
                println superuser.errors
            }
        }
    }
    def destroy = {
    }
}
