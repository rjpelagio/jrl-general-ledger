package com.app

import groovy.sql.Sql
class AppSearchService {

    static transactional = true

    def dataSource

    def serviceMethod() {

    }
    
    def getUsers(String username, AppRole role, Party party) {
        String newUserName = "%%"
        if(username){
            newUserName = "%" + username + "%"
        }
        //String newFirstName = "%" + firstName + "%";
        //String newLastName = "%" + lastName + "%";
        
        //def result = AppUser.executeQuery("\
        //    FROM AppUser user\
        //    WHERE user.username LIKE ?\
        //    AND user.firstName LIKE ?\
        //    AND user.lastName LIKE ?\
        //    AND user.role = ?", [newUserName, newFirstName, newLastName, role]
        //)


        def result = AppUser.executeQuery("\
            FROM AppUser user\
            WHERE user.username LIKE ?", [newUserName]
        )

        def sample = ("SELECT *\
            FROM AppUser user\
            WHERE user.username LIKE "+ [newUserName]
        )
        
        if(role || party){
            if(role!=null && party==null){
                result = AppUser.executeQuery("\
                    FROM AppUser user\
                    WHERE user.username LIKE ?\
                    AND user.role = ?", [newUserName, role]
                )
            }
            else if(role==null && party!=null){
                result = AppUser.executeQuery("\
                    FROM AppUser user\
                    WHERE user.username LIKE ?\
                    AND user.party = ?", [newUserName, party]
                )
            }
            else if (role!=null && party!=null){
                result = AppUser.executeQuery("\
                    FROM AppUser user\
                    WHERE user.username LIKE ?\
                    AND user.party = ?\
                    AND user.role = ?", [newUserName, party, role]
                )
            }
        }
        
        
        return result;
    }
    
    def getRoles(String roleCode, String roleName, AppRole parent) {
        
        String newRoleCode = "%" + roleCode + "%";
        String newRoleName = "%" + roleName + "%";
        
        def result = AppRole.executeQuery("\
            FROM AppRole role\
            WHERE role.roleCode LIKE ?\
            AND role.roleName LIKE ?\
            AND role.parent =  ?", [newRoleCode, newRoleName, parent]
        )
    }

    def getParty(String name, String firstName, String middleName, String lastName, String tin) {

        String newName = "%%"
        String newFirstName = "%%"
        String newMiddleName = "%%"
        String newLastName = "%%"
        String newTin = "%%"

        if(name){
            newName = "%"+ name +"%"
        }

        if(firstName){
            newFirstName = "%"+ firstName +"%"
        }

        if(middleName){
            newMiddleName = "%"+ middleName +"%"
        }

        if(lastName){
            newLastName = "%"+ lastName +"%"
        }

        if(tin){
            newTin = "%"+ tin +"%"
        }

        def result = Party.executeQuery("\
            FROM Party party\
            WHERE party.name LIKE ?\
            AND party.firstName LIKE ?\
            AND party.lastName LIKE ?\
            AND party.middleName LIKE ?\
            AND party.tin LIKE ?", [newName, newFirstName, newLastName, newMiddleName, newTin]
        )

        return result
    }

    def getEmployees(String name, String firstName, String middleName, String lastName, String tin, String department, String position) {

        def db = new Sql(dataSource)
        String newName = "%%"
        String newFirstName = "%%"
        String newMiddleName = "%%"
        String newLastName = "%%"
        String newTin = "%%"

        if(name){
            newName = "%"+ name +"%"
        }

        if(firstName){
            newFirstName = "%"+ firstName +"%"
        }

        if(middleName){
            newMiddleName = "%"+ middleName +"%"
        }

        if(lastName){
            newLastName = "%"+ lastName +"%"
        }

        if(tin){
            newTin = "%"+ tin +"%"
        }

        def result = db.rows("SELECT *\
            FROM employee\
            WHERE party_id IN\
            (SELECT party_id\
            FROM party\
            WHERE name LIKE ?\
            AND first_name LIKE ?\
            AND last_name LIKE ?\
            AND middle_name LIKE ?\
            AND tin LIKE ?)", [newName, newFirstName, newLastName, newMiddleName, newTin]
        )

        result = db.rows("SELECT *\
            FROM employee\
            JOIN party ON employee.party_id = party.party_id\
            WHERE name LIKE '"+ newName +"'\
           AND first_name LIKE '"+ newFirstName +"'\
            AND last_name LIKE '"+ newLastName +"'\
            AND middle_name LIKE '"+ newMiddleName +"'\
            AND tin LIKE '"+ newTin +"'\
            ")


        //def sample = ("SELECT *\
        //    FROM employee\
        //    WHERE party_id IN\
        //    (SELECT party_id\
        //    FROM party\
        //    WHERE name LIKE '"+ newName + "'\
        //    AND first_name LIKE '"+ newFirstName + "'\
        //    AND last_name LIKE '"+ newLastName + "'\
        //    AND middle_name LIKE '"+ newMiddleName + "'\
        //    AND tin LIKE '"+ newTin + "'")
        //println "1: " + position + ", " + department

        if(department || position){
            if(department!='null' && position!='null'){
                result = db.rows("SELECT *\
                    FROM employee\
                    WHERE department = ?\
                    AND position = ?\
                    AND party_id IN\
                    (SELECT party_id\
                    FROM party\
                    WHERE name LIKE ?\
                    AND first_name LIKE ?\
                    AND last_name LIKE ?\
                    AND middle_name LIKE ?\
                    AND tin LIKE ?)", [department, position, newName, newFirstName, newLastName, newMiddleName, newTin]
                )
                //println "2"
            }
            else if(department!='null' && position=='null'){
                result = db.rows("SELECT *\
                    FROM employee\
                    WHERE department = ?\
                    AND party_id IN\
                    (SELECT party_id\
                    FROM party\
                    WHERE name LIKE ?\
                    AND first_name LIKE ?\
                    AND last_name LIKE ?\
                    AND middle_name LIKE ?\
                    AND tin LIKE ?)", [department, newName, newFirstName, newLastName, newMiddleName, newTin]
                )
                //println "3"
            }
            else if (department=='null' && position!='null'){
                result = db.rows("SELECT *\
                    FROM employee\
                    WHERE position = ?\
                    AND party_id IN\
                    (SELECT party_id\
                    FROM party\
                    WHERE name LIKE ?\
                    AND first_name LIKE ?\
                    AND last_name LIKE ?\
                    AND middle_name LIKE ?\
                    AND tin LIKE ?)", [position, newName, newFirstName, newLastName, newMiddleName, newTin]
                )
                //println "4"
            }
        }

        return result
    }
}
