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
        String newDepartment = "%%"
        String newPosition = "%%"

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

        if(department){
            newDepartment = "%"+ department +"%"
        }

        if(position){
            newPosition = "%"+ position +"%"
        }

        println 'department ' + department

        def result = db.rows("SELECT employee.id, party.last_name, party.first_name, party.middle_name, party.tin, employee.department, employee.position, employee.status\
            FROM party\
            JOIN employee ON employee.party_id = party.party_id\
            WHERE (party.last_name LIKE ?\
            AND party.first_name LIKE ?\
            AND party.middle_name LIKE ?\
            AND party.tin LIKE ?)\
            AND (employee.department LIKE ?\
            OR employee.position LIKE ?)", [newLastName, newFirstName, newMiddleName, newTin, newDepartment, newPosition]
        )
        
        return result
    }
}
