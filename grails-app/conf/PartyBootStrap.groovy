import grails.util.GrailsUtil
import com.app.*
import com.gl.*
import groovy.sql.Sql
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import org.codehaus.groovy.grails.commons.ApplicationHolder

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

        def empLogin = new AppUser(username:"rjpelagio",
                    password:"rjpelagio",
                    dateCreated: new Date(),
                    lastLogin: new Date(),
                    lastUpdated : new Date(),
                    role:AppRole.findByRoleCode('EMP'),
                    party:Party.find(empParty))
        if(!AppUser.findByUsername("rjpelagio")){
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

        def supLogin = new AppUser(username:"ynamacaspac",
                    password:"ynamacaspac",
                    dateCreated: new Date(),
                    lastLogin: new Date(),
                    lastUpdated : new Date(),
                    role:AppRole.findByRoleCode('EMP'),
                    party:Party.find(supParty))
        if(!AppUser.findByUsername("ynamacaspac")){
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

        def cleLogin = new AppUser(username:"claram",
                    password:"claram",
                    dateCreated: new Date(),
                    lastLogin: new Date(),
                    lastUpdated : new Date(),
                    role:AppRole.findByRoleCode('EMP'),
                    party:Party.find(cleParty))
        if(!AppUser.findByUsername("claram")){
            cleLogin.save()
            if(cleLogin.hasErrors()){
                println cleLogin.errors
            }
        }

        /** END CLERK SAMPLE DATA ENTRY **/

        def sql = Sql.newInstance(CH.config.dataSource.url, CH.config.dataSource.username,
        CH.config.dataSource.password, CH.config.dataSource.driverClassName)

        String sqlFilePath =  ApplicationHolder.application.parentContext.servletContext.getRealPath("/data/seed_employee.sql")
        String sqlString = new File(sqlFilePath).text
        
        sql.execute(sqlString)

	}

	def destroy = {

	}


}