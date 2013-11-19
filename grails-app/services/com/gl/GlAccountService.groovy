/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.gl

import com.app.*
import groovy.sql.Sql

/**
 *
 * @author rina
 */
class GlAccountService {
    static transactional = true
    def dataSource

    def serviceMethod() {

    }

    def updateAccount(def glAccountId, def organization, def glAccountOrganizationInstance) {
        def db = new Sql(dataSource)
        def orgLength = 0
        def organizationList = ""
        def organization1 = 1
        if(organization!=null){
            def orgSize = organization.size()
            
            for(int i=0; i<orgSize; i++){
                organizationList = organizationList + organization[i]
                
                if(i!=(orgSize-1)){
                    organizationList = organizationList + ","
                }
            }
            //Delete all not added in the form. But check if it is already used as transaction in the acctg_trans.
            def deleteOrganizationList = db.execute("DELETE\
                FROM gl_account_organization\
                WHERE gl_account_id = '"+ glAccountId.id +"'\
                AND organization_id NOT IN\
                    (SELECT organization_id\
                    FROM gl_accounting_transaction INNER JOIN gl_accounting_transaction_details\
                    ON gl_accounting_transaction.id=gl_accounting_transaction_details.gl_accounting_transaction_id\
                    WHERE gl_account_id = '"+ glAccountId.id +"')\
                AND organization_id NOT IN ("+ organizationList +")")

            def insertOrganizationList = db.rows("SELECT id\
                FROM app_organization\
                WHERE id NOT IN \
                    (SELECT organization_id\
                    FROM gl_account_organization\
                    WHERE gl_account_id = '"+ glAccountId.id +"')\
                AND id IN ("+ organizationList +")")

            
            
            orgLength = insertOrganizationList.size()

            for (int i=0; i< orgLength; i++) {
                def glAccountOrganization = new GlAccountOrganization()

               glAccountOrganization.glAccount = GlAccount.get(glAccountId.id)
                glAccountOrganization.organization = AppOrganization.get(insertOrganizationList.id[i])
                glAccountOrganization.startDate = new Date()

                glAccountOrganization.save()
                if (glAccountOrganization.hasErrors()) {
                    println glAccountOrganization.errors
                }
            }
        }
        else{
            def deleteOrganizationList = db.execute("DELETE\
                FROM gl_account_organization\
                WHERE gl_account_id = '"+ glAccountId.id +"'")
        }
        
    }
    def insertAccount(def glAccountId, def organization) {
        for (int i = 0; i < organization.size(); i++) {
            def glAccountOrganization = new GlAccountOrganization()
            
            glAccountOrganization.glAccount = GlAccount.get(glAccountId.id)
            glAccountOrganization.organization = AppOrganization.get(organization[i])
            glAccountOrganization.startDate = new Date()

            glAccountOrganization.save()
            if (glAccountOrganization.hasErrors()) {
                println glAccountOrganization.errors
            }
        }
    }

    def delete(def glAccountId, def organization) {
    }
}

