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

    def getParty(String name, String firstName, String middleName, String lastName, String tin, String role) {

        def db = new Sql(dataSource)
        String newName = "%%"
        String newRole = "%%"

        if(name){
            newName = "%"+ name +"%"
        }

        if(role){
            newRole = "%" + role + "%"
        }

        def result = db.rows("SELECT party.party_id as id, party.name, \
            party.tin as tin, \
            party_role.role as role, \
            party_role.status as status, \
            tele_info.area_code as areaCode, \
            tele_info.contact_number as contactNumber, \
            tele_info.mobile_number as mobileNumber, \
            postal_address.city as city, \
            postal_address.province as province \
            FROM party \
            JOIN party_role ON party_role.party_id = party.party_id \
            JOIN party_contact_mech AS a \
                ON a.party_id = party.party_id \
                AND a.contact_mech_type = 'PHONE_INFO' \
            JOIN tele_info ON tele_info.contact_mech_id = a.contact_mech_id \
            JOIN party_contact_mech AS b \
                ON b.party_id = party.party_id \
                AND b.contact_mech_type = 'POSTAL_ADDRESS' \
            JOIN postal_address ON postal_address.contact_mech_id = b.contact_mech_id \
            WHERE party.name LIKE ? \
            AND party_role.role LIKE ?", [newName, newRole]
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

        def result = db.rows("SELECT employee.id, party.last_name, party.first_name, party.middle_name, party.tin, employee.department, employee.position, employee.status\
            FROM party\
            JOIN employee ON employee.party_id = party.party_id\
            WHERE (party.last_name LIKE ?\
            AND party.first_name LIKE ?\
            AND party.middle_name LIKE ?\
            AND party.tin LIKE ?)\
            AND employee.department LIKE ?\
            ", [newLastName, newFirstName, newMiddleName, newTin, newDepartment]
        )
        
        return result
    }
}
